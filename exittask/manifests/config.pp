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

    file { '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      notify  => Service['puppetserver'],
      content => template('exittask/db_puppet.erb')
    }

    file { '/etc/puppetlabs/code/environments/production/manifests/site.pp':
      ensure => file,
      source => 'puppet:///modules/exittask/site.pp',
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