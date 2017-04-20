class etask::pcl {
host { 'server.minsk.epam.com':
    ensure => present,
    ip     => '192.168.0.5',
  }
host { 'client.minsk.epam.com':
    ensure => present,
    ip     => '192.168.0.2',
  }
file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure  => file,
    source => '/vagrant/modules/etask/files/puppet.conf',
  }
}
