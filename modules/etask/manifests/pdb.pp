class etask::pdb {
package { 'postgresql96-contrib':
    source => 'https://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm',
    ensure => present, 
  }
package { 'postgresql96-server': 
    source => 'https://yum.postgresql.org/9.6/redhat/rhel-7-x86_64/pgdg-centos96-9.6-3.noarch.rpm',
    ensure => present, 
    require => Package['postgresql96-contrib'], 
  }

exec { '/usr/pgsql-9.6/bin/postgresql96-setup initdb':
    refreshonly => true,
    subscribe   => Package['postgresql96-server'],
    require     => Package['postgresql96-server'],
  }
file { '/var/lib/pgsql/9.6/data/pg_hba.conf':
    ensure  => file,
    source => '/vagrant/modules/etask/files/pg_hba.conf',
    require => Exec['/usr/pgsql-9.6/bin/postgresql96-setup initdb'],
  }
service { 'postgresql-9.6':
    ensure => running,
    enable => true,
    require => File['/var/lib/pgsql/9.6/data/pg_hba.conf'],
  }

exec { 'create user':
    user        => 'postgres',
    command     => 'psql -c "CREATE USER puppetdb WITH PASSWORD \'puppetdb\';"',
    path        => '/bin/',
    subscribe   => Package['postgresql96-server'],
    refreshonly => true,
    require     => Service['postgresql-9.6'],
  }
exec { 'create database':
    user        => 'postgres',
    command     => 'create database puppetdb;',
    path        => '/bin/',
    subscribe   => Package['postgresql96-server'],
    refreshonly => true,
    require     => Service['postgresql-9.6'],
  }
exec { 'install extension pg_trgm':
    user        => 'postgres',
    command     => "psql -c 'create extension pg_trgm;'",
    path        => '/bin/',
    subscribe   => Package['postgresql96-contrib'],
    refreshonly => true,
    require     => Service['postgresql-9.6'],
  }
package { 'puppetdb': ensure => present }
package { 'puppetdb-termini': ensure => present }

file { '/etc/puppetlabs/puppetdb/conf.d/database.ini':
    ensure  => file,
    source => '/vagrant/modules/etask/files/database.ini',
    require => Package['puppetdb'],
  }
file { '/etc/puppetlabs/puppet/puppetdb.conf':
    ensure  => file,
    source => '/vagrant/modules/etask/files/puppetdb.conf',
    require => Package['puppetdb'],
  }
file { '/etc/puppetlabs/puppet/routes.yaml':
    ensure => file,
    source => '/vagrant/modules/etask/files/routes.yaml',
    require => Package['puppetdb'],
  }
file { '/etc/puppetlabs/puppet/puppet.conf':
    ensure => file,
    source => '/vagrant/modules/etask/files/m_puppet.conf',
    notify => Service['puppetserver'],
    require => Package['puppetdb'],
  }
service { 'puppetdb':
    ensure => running,
    enable => true,
    require => File['/etc/puppetlabs/puppet/puppetdb.conf'],
  }
}
