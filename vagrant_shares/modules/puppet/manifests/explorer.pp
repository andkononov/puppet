class puppet::explorer {

  file { 'explorer.rpm':
    ensure   => file,
    path   => '/tmp/puppetexplorer-2.0.0-SNAPSHOT20170417090008.noarch.rpm',
    source => '/vagrant/vagrant_shares/modules/puppet/files/puppetexplorer-2.0.0-SNAPSHOT20170417090008.noarch.rpm',
  }

  package { 'explorer':
    ensure   => installed,
    source   => '/tmp/puppetexplorer-2.0.0-SNAPSHOT20170417090008.noarch.rpm',
    provider => rpm,
    require  => File['explorer.rpm'],
  }

  file { 'app.js':
    ensure   => file,
    path     => '/tmp/share/puppetexplorer/app.js',
    source   => '/vagrant/vagrant_shares/modules/puppet/files/app.js',
    require  => Package['explorer'],
  }

  file { 'config.js':
    ensure   => file,
    path     => '/tmp/share/puppetexplorer/config.js',
    source   => '/vagrant/vagrant_shares/modules/puppet/files/config.js',
    require  => Package['explorer'],
  }
}

