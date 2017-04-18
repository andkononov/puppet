# Puppet explorer installation
class exittask::explorer inherits exittask {

  package { 'mod_ssl':
    ensure => installed,
  }

  exec { 'yum install -y puppetexplorer-2.0.0.noarch.rpm':
    cwd  => '/vagrant/modules/exittask/files',
    path => ['/usr/bin', '/usr/sbin',],
  }
}