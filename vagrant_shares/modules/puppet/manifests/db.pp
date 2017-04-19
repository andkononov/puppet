class puppet::db {

  file { 'postgresql-repo.rpm':
    path   => '/tmp/postgresql-repo.rpm',
    source => 'https://download.postgresql.org/pub/repos/yum/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm',
  }

  package { 'pgdg-centos96':
    ensure   => present,
    source   => '/tmp/postgresql-repo.rpm',
    provider => rpm,
    require  => File['/tmp/postgresql-repo.rpm'],
  }

  package { 'postgresql96-server':
    ensure   => installed,
    provider => rpm,
    require  => Package['pgdg-centos96'],
  }

  package { 'postgresql96-contrib':
    ensure   => installed,
    provider => rpm,
    require  => Package['postgresql96-server'],
  }

  exec { '/usr/pgsql-9.6/bin/postgresql96-setup initdb':
    refreshonly => true,
    subscribe   => Package['postgresql96-server'],
  }

  service { 'postgresql-9.6':
    ensure => running,
    enable => true,
  }

  exec { 'create postgresql user':
    user        => 'postgres',
    command     => 'psql -c "CREATE USER puppetdb WITH PASSWORD \'puppetdb\';"',
    path        => '/bin/',
    subscribe   => Package['postgresql96-server'],
    refreshonly => true,
    require     => Service['postgresql-9.6'],
  }

  exec { 'create postgresql database':
    user        => 'postgres',
    command     => 'createdb -E UTF8 -O puppetdb puppetdb',
    path        => '/bin/',
    subscribe   => Package['postgresql96-server'],
    refreshonly => true,
    require     => Service['postgresql-9.6'],
  }

  exec { 'install extension pg_trgm':
    user        => 'postgres',
    command     => "psql -c 'create extension pg_trgm'",
    path        => '/bin/',
    subscribe   => Package['postgresql96-contrib'],
    refreshonly => true,
    require     => Service['postgresql-9.6'],
  }


  package { 'puppetdb':
    ensure => present,
  }

  package { 'puppetdb-termini':
    ensure => present,
  }


  file { 'database.ini':
    ensure => file,
    path   => '/etc/puppetlabs/puppetdb/conf.d/database.ini',
    source => '/vagrant/vagrant_shares/modules/puppet/files/database.ini',
    owner  => 'puppetdb',
    group  => 'puppetdb',
  }

  file { 'pg_hba.conf':
    ensure   => file,
    path     => '/var/lib/pgsql/9.6/data/pg_hba.conf',
    source   => '/vagrant/vagrant_shares/modules/puppet/files/pg_hba.conf',
    owner    => 'postgres',
    group    => 'postgres',
  }


  file { 'puppet.conf':
    ensure   => file,
    path     => '/etc/puppetlabs/puppet/puppet.conf',
    source   => '/vagrant/vagrant_shares/modules/puppet/files/puppet.conf',
    owner    => 'puppet',
    group    => 'puppet',
    require => Package['puppetdb'],
  }


  file { 'puppetdb.conf':
    ensure   => file,
    path     => '/etc/puppetlabs/puppet/puppetdb.conf',
    source   => '/vagrant/vagrant_shares/modules/puppet/files/puppetdb.conf',
    owner    => 'puppet',
    group    => 'puppet',
    notify => Service['puppetserver'],
    require => Package['puppetdb'],
  }

  file { 'routes.yaml':
    ensure => file,
    path   => '/etc/puppetlabs/puppet/routes.yaml',
    source => '/vagrant/vagrant_shares/modules/puppet/files/routes.yaml',
    owner  => 'puppet',
    group  => 'puppet',
    require => Package['puppetdb'],
  }

  file { '/etc/puppetlabs/puppet':
    ensure  => directory,
    owner   => 'puppet',
    group   => 'puppet',
    recurse => true,
    require => Package['puppetdb'],
  }

  service { 'puppetdb':
    ensure => running,
    enable => true,
    require => File['puppetdb.conf'],
  }
}