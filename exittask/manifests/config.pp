# Configure puppet
class exittask::config inherits exittask::params {

  if $::is_master {
    file { '/etc/puppetlabs/puppet/autosign.conf':
      ensure  => file,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      notify  => Service['puppetserver'],
      content => template('exittask/autosign.erb')
    }

    if $is_puppetdb {
      file { '/etc/puppetlabs/puppet/puppet.conf':
        ensure => file,
        source => 'puppet:///modules/exittask/db_puppet.conf',
      }

      file { '/etc/puppetlabs/puppet/routes.yaml':
        ensure => file,
        source => 'puppet:///modules/exittask/routes.yaml',
      }

      file { '/etc/puppetlabs/puppet/puppetdb.conf':
        ensure  => file,
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        content => template('exittask/puppetdb.erb'),
        notify  => Service[puppetserver, puppetdb],
      }

      file { '/etc/puppetlabs/puppetdb/conf.d/database.ini':
        ensure  => file,
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        content => template('exittask/database.erb'),
        notify  => Service[puppetserver, puppetdb],
      }
    }
  }
  else {
    file { '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      content => template('exittask/client_puppet.erb')
    }
  }
}