class puppet_install::master_inst 

{
  notify { 'Master': }

  package { 'puppetserver':
    ensure  => $::puppet_install::puppet_serv_ver,
    require => Yumrepo['puppet_repo'],
  }

  yumrepo { 'puppet_repo':
    ensure   => 'present',
    baseurl  => $::puppet_install::baseurl,
    gpgkey   => $::puppet_install::gpgkey,
    enabled  => '1',
    gpgcheck => '1',
  }

  file { 'autosign':
    path    => $::puppet_install::autosign_path,
    content => template('puppet_install/autosign.erb'),
    require => Package['puppetserver'],
  }

  service { 'puppetserver':
    ensure  => 'running',
    enable  => true,
    require => Package['puppetserver'],
  }  

}
