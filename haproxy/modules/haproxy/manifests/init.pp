class haproxy{
$proxy_site = 'tut.by'
    package { 'haproxy':
    ensure => 'present',
    
  }

  file { '/etc/haproxy/haproxy.cfg':
    ensure  => file,
    content => template('haproxy/haproxy.cfg.erb'),
    #mode    => '0644',
  }

  service { 'haproxy':
    ensure  => 'running',
    enable  => true,
    require => Package['haproxy'],
  }
}