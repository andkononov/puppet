# Puppet explorer installation
class exittask::explorer inherits exittask {

  package { 'mod_ssl':
    ensure => installed,
  }

  service { 'httpd':
    ensure     => running,
    name       => 'httpd',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-puppetexplorer':
    ensure => file,
    source => 'puppet:///modules/puppetexplorer/RPM-GPG-KEY-puppetexplorer',
    before => Yumrepo['puppetexplorer'],
  }

  yumrepo { 'puppetexplorer':
    ensure        => present,
    descr         => 'Puppet Explorer',
    baseurl       => 'http://yum.puppetexplorer.io/',
    enabled       => true,
    gpgcheck      => 0,
    repo_gpgcheck => 1,
    gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-puppetexplorer',
    before        => Package['puppetexplorer'],
  }

  package { 'puppetexplorer':
    ensure => installed,
  }

  file { '/usr/share/puppetexplorer/config.js':
    ensure => file,
    source => 'puppet:///modules/exittask/config.js',
    require => Package['puppetexplorer'],
  }

  file { '/etc/httpd/conf.d/25-ppuppetexplorer.conf':
    ensure  => file,
    mode    => '0755',
    owner   => 'root',
    group   => 'root',
    content => template('exittask/25-puppetexplorer.erb'),
    notify  => Service['httpd'],
  }
}