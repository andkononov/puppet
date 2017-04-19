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

  exec { 'yum install -y puppetexplorer-2.0.0.noarch.rpm':
    cwd  => '/vagrant/modules/exittask/files',
    path => ['/usr/bin', '/usr/sbin',],
  }

  file { '/usr/share/puppetexplorer/config.js':
    ensure => file,
    source => 'puppet:///modules/exittask/config.js',
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