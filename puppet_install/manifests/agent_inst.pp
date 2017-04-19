class puppet_install::agent_inst 

  {
  notify { 'Agent': }

  package { 'puppet-agent':
    ensure  => $::puppet_install::puppet_agent_ver,
    require => Yumrepo['puppet_repo'],
  }

  yumrepo { 'puppet_repo':
    ensure   => 'present',
    baseurl  => $::puppet_install::baseurl,
    gpgkey   => $::puppet_install::gpgkey,
    enabled  => '1',
    gpgcheck => '1',
  }

  exec {'puppet_conf':
    command => 'echo "server = master.loc" >> /etc/puppetlabs/puppet/puppet.conf',
    path => ['/usr/bin', '/usr/sbin',],    
    require => Package['puppet-agent'],
  }

  service { 'puppet':
    ensure  => 'running',
    enable  => true,
    require => Exec['puppet_conf'],
  }

  include puppet_install::lighttpd

   
  
}


