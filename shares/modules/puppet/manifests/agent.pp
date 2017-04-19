# Install puppet agent
class puppet::agent {

  # Install puppet-agent
  package { 'puppet-agent':
    ensure  => installed,
    name    => puppet-agent,
    require => Yumrepo['rpm'],
  }

  # start puppet-agent service
  service { 'puppet':
    ensure  => 'running',
    enable  => true,
    require => Package['puppet-agent'],
  }
}
