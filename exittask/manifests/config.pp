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

    file { '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      notify  => Service['puppetserver'],
      content => template('exittask/db_puppet.erb'),
    }

    file { '/etc/puppetlabs/code/environments/production/manifests/site.pp':
      ensure => file,
      source => 'puppet:///modules/exittask/site.pp',
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

    file { '/etc/puppetlabs/puppet/puppet.conf':
      ensure  => file,
      mode    => '0755',
      owner   => 'root',
      group   => 'root',
      content => template('exittask/client_puppet.erb'),
      notify  => Service['puppet'],
    }

  }
}