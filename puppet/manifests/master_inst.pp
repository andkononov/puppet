class puppet::master_inst (
  ) inherits puppet::params

{
  notify { 'Master': }

  package { 'puppetserver':
    ensure  => installed,
    require => Yumrepo['puppet_repo'],
  }

  yumrepo { 'puppet_repo':
    ensure   => 'present',
    baseurl  => "$baseurl",
    gpgkey   => "$gpgkey",
    enabled  => '1',
    gpgcheck => '1',
  }

  file { 'autosign':
    path    => "$autosign_path",
    content => template('puppet/autosign.erb'),
    require => Package['puppetserver'],
  }

  service { 'puppetserver':
    ensure  => 'running',
    enable  => true,
    require => Package['puppetserver'],
  }  

}
