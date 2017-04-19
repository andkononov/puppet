class puppet::agent_inst  (
  ) inherits puppet::params

  {
  notify { 'Agent': }

  package { 'puppet-agent':
    ensure  => installed,
    require => Yumrepo['puppet_repo'],
  }

  yumrepo { 'puppet_repo':
    ensure   => 'present',
    baseurl  =>  "$baseurl",
    gpgkey   =>  "$gpgkey",
    enabled  => '1',
    gpgcheck => '1',
  }

  service { 'puppet':
    ensure  => 'running',
    enable  => true,
    require => Package['puppet-agent'],
  }
  
}


