class exittask::agent {

  exec { 'Register_repo':
      command => 'rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      path    => ['/usr/bin', '/usr/sbin',],
  }

  package { 'puppet-agent':
  ensure  => 'latest',
  require => Exec['Register_repo']
  }  
  
  service { 'puppet':
  ensure  => 'running',
  require => Package['puppet-agent'],
  }
  
  host { 'master.epbyminw2695.minsk.epam.com':
  host_aliases => 'puppet',
  ip           => '172.16.10.10',
  }
  
  host { 'agent.epbyminw2695.minsk.epam.com':
  ip           => '172.16.10.20',
  }
  
  exec { '/etc/puppetlabs/puppet/puppet.conf':
  command     => 'echo "server = master.epbyminw2695.minsk.epam.com" >> /etc/puppetlabs/puppet/puppet.conf',
  path        => ['/usr/bin', '/usr/sbin',],
  require     => Service['puppet'],
  refreshonly => true
  }

  exec { 'test':
    command => '/opt/puppetlabs/bin/puppet agent -t',
    path    => ['/usr/bin', '/usr/sbin',],
    require => Package['puppet-agent']
  }
  
}
