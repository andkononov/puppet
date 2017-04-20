# Configure puppet
class exittask::config inherits exittask::params {

  if $::is_master {
    file { 'autosign.conf':
      ensure  => file,
      path    => '/etc/puppetlabs/puppet/autosign.conf',
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      notify  => Service['puppetserver'],
      content => template('exittask/autosign.erb'),
    }

    file { '/etc/puppetlabs/code/environments/production/manifests/site.pp':
      ensure => file,
      source => 'puppet:///modules/exittask/site.pp',
    }

    if $is_puppetdb {
      file { 'master_db_puppet.conf':
        ensure  => file,
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        replace => true,
        content => template('exittask/db_puppet.erb'),
      }
    } else {
      file { 'master_puppet.conf':
        ensure  => file,
        path    => '/etc/puppetlabs/puppet/puppet.conf',
        mode    => '0755',
        owner   => 'root',
        group   => 'root',
        notify  => Service['puppetserver'],
        content => template('exittask/master_puppet.erb'),
        notify  => Service['puppet'],
      }

      service { 'puppet':
        ensure     => running,
        name       => 'puppet',
        enable     => true,
        hasstatus  => true,
        hasrestart => true,
      }
    }
  }
  else {

    service { 'puppet':
      ensure     => running,
      name       => 'puppet',
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }

    file { 'client_puppet.conf':
      ensure  => file,
      path    => '/etc/puppetlabs/puppet/puppet.conf',
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      content => template('exittask/client_puppet.erb'),
      notify  => Service['puppet'],
    }

  }
}