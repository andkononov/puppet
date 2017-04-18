class etask::pcl {
file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure  => file,
    source => '/vagrant/modules/etask/files/puppet.conf',
}
exec { 'connect to server':
    user        => 'root',
    command     => 'puppet agent -t',
    path        => '/opt/puppetlabs/bin/',
#    cwd         => '/var/lib/pgsql',
    refreshonly => true,
    require     => File['/etc/puppetlabs/puppet/puppet.conf'],
  }
}
