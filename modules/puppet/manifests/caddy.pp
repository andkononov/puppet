# install caddy

class puppet::caddy(String $proxy_url = 'google.com') {

 $port = '2050'

# copy caddy file
  file { 'caddy':
    ensure => file,
    path   => '/usr/local/bin/caddy',
    source => '/vagrant/caddy/caddy',
    owner  => 'root',
    group  => 'root',
    mode   => '0755',
  }

# setcap
  exec {'setcap':
    command     => "setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy",
    path        => ['/usr/bin', '/usr/sbin',],
    subscribe   => File['caddy'],
    refreshonly => true,
  }

# create new group
  group { 'www-data':
    ensure => present,
    gid    => '33',
  }

# create new user
  user { 'www-data':
    ensure => present,
    gid    => www-data,
    shell  => '/usr/sbin/nologin',
    home   => '/var/www',
    system => true,
    uid    => '33',
  }

# create /etc/caddy
  file {'/etc/caddy':
    ensure => directory,
    owner  => 'root',
    group  => 'www-data',
  }

# create /etc/ssl/caddy
  file {'/etc/ssl/caddy':
    ensure => directory,
    owner  => 'www-data',
    group  => 'root',
    mode   => '0770',
  }

# add Caddyfile
  file { '/etc/caddy/Caddyfile':
    ensure  => file,
    content => template('puppet/Caddyfile.erb'),
    owner   => 'www-data',
    group   => 'www-data',
    mode    => '0444',
    notify  => Service['caddy']
  }

# create /var/www
  file {'/var/www':
    ensure => directory,
    owner  => 'www-data',
    group  => 'www-data',
    mode   => '0555',
  }

# copy systemctl
  file { 'sysctl':
    ensure => file,
    path   => '/etc/systemd/system/caddy.service',
    source => '/vagrant/caddy/init/linux-systemd/caddy.service',
    owner  => 'root',
    group  => 'root',
    mode   => '0744',
  }

# reload systemctl daemon-reload
  exec {'reload':
    command     => 'systemctl daemon-reload',
    path        => ['/usr/bin', '/usr/sbin',],
    subscribe   => File['sysctl'],
    refreshonly => true,
  }

# start caddy service
  service { 'caddy':
    ensure => 'running',
    enable => true,
  }
}
