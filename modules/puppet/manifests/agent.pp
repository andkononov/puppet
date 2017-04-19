# Install puppet agent
class puppet::agent {

  # Install puppet-agent
  package { 'puppet-agent':
    ensure  => installed,
    name    => puppet-agent,
    require => Yumrepo['rpm'],
  }

# Add puppet.conf
  exec {'alias':
    command     => 'echo "server = server.bm" >> /etc/puppetlabs/puppet/puppet.conf',
    path        => ['/usr/bin', '/usr/sbin',],
    subscribe   => Package['puppet-agent'],
    refreshonly => true,
  }

  # start puppet-agent service
  service { 'puppet':
    ensure  => 'running',
    enable  => true,
    require => Exec['alias'],
  }
}


