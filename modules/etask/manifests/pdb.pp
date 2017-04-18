class etask::pdb {
package { 'postgresql-contrib': ensure => present }
package { 'postgresql-server': ensure => present, require => Package['postgresql-contrib'] }

exec { '/bin/postgresql-setup initdb':
    refreshonly => true,
    subscribe   => Package['postgresql-server'],
    require     => Package['postgresql-server'],
  }
file { '/var/lib/pgsql/data/pg_hba.conf':
    ensure  => file,
    source => '/vagrant/modules/etask/files/pg_hba.conf',
    require => Exec['/bin/postgresql-setup initdb'],
  }
service { 'postgresql':
    ensure => running,
    enable => true,
    require => File['/var/lib/pgsql/data/pg_hba.conf'],
  }

exec { 'create user':
    user        => 'postgres',
    command     => 'psql -c "CREATE USER puppetdb WITH PASSWORD \'puppetdb\';"',
    path        => '/bin/',
    subscribe   => Package['postgresql-server'],
    refreshonly => true,
    require     => Service['postgresql'],
  }
exec { 'create database':
    user        => 'postgres',
    command     => 'createdb -E UTF8 -O puppetdb puppetdb',
    path        => '/bin/',
    subscribe   => Package['postgresql-server'],
    refreshonly => true,
    require     => Service['postgresql'],
  }
exec { 'install extension pg_trgm':
    user        => 'postgres',
    command     => "psql -c 'create extension pg_trgm'",
    path        => '/bin/',
    subscribe   => Package['postgresql-contrib'],
    refreshonly => true,
    require     => Service['postgresql'],
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
    require => Package['puppetdb'],
  }
service { 'puppetdb':
    ensure => running,
    enable => true,
    require => File['/etc/puppetlabs/puppet/puppetdb.conf'],
  }
}
