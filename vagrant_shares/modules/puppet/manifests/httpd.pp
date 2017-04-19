class puppet::httpd {

  package { 'httpd':
    ensure   => installed,
  }

  file { 'master.conf':
    path   => '/etc/httpd/conf.d/master.conf',
    source => '/vagrant/vagrant_shares/modules/puppet/files/master.conf',
    require => Package['httpd'],
  }

  service { 'httpd':
    ensure  => running,
    name    => 'httpd',
    enable  => true,
    require => File['httpd.conf'],
  }
}