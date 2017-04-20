# Postgres installation
class exittask::postgres {

  exec { 'yum install -y http://yum.postgresql.org/9.4/redhat/rhel-7-x86_64/pgdg-redhat94-9.4-2.noarch.rpm':
    path   => ['/usr/bin', '/usr/sbin',],
    onlyif => [ '[ ! -f /etc/yum.repos.d/pgdg-94-redhat.repo ]' ],
  }

  package { 'postgresql94-server':
    ensure => installed,
  }

  package { 'postgresql94-contrib':
    ensure => installed,
  }

  exec { '/usr/pgsql-9.4/bin/postgresql94-setup initdb':
    path    => ['/usr/bin', '/usr/sbin', ],
    require => Package[postgresql94-server],
    onlyif  => [ '[ ! -f /var/lib/pgsql/9.4/initdb.log ]' ],
  }

  file { '/var/lib/pgsql/9.4/data/pg_hba.conf':
    ensure  => file,
    mode    => '0755',
    owner   => 'postgres',
    group   => 'postgres',
    content => template('exittask/pg_hba.erb'),
    notify  => Service['postgresql-9.4'],
    require => Exec['/usr/pgsql-9.4/bin/postgresql94-setup initdb'],
  }

  service { 'postgresql-9.4':
    ensure     => running,
    name       => 'postgresql-9.4',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Exec['/usr/pgsql-9.4/bin/postgresql94-setup initdb'],
  }

  $set_pass_cmd = "create user ${exittask::params::pg_db_user} password '${exittask::params::pg_db_pass}'"
  $set_db_cmd = "create database ${exittask::params::pg_db} owner ${exittask::params::pg_db_user}"

  exec { 'createuser':
    cwd     => '/',
    command => "sudo -u postgres psql -c \"${set_pass_cmd}\" || echo 'User already exists'",
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'createdb':
    cwd     => '/',
    command => "sudo -u postgres psql -c \"${set_db_cmd}\" || echo 'Database already exists'",
    path    => ['/usr/bin', '/usr/sbin',],
  }
}