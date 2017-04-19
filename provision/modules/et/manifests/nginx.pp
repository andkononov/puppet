class et::nginx {
  package { 'nginx':
    ensure => latest
  }

 file { '/usr/share/nginx/html/index.html':
   ensure  => file,
   content => template('et/index.erb'),
   owner   => root,
   group   => root,
   mode    => '0644',
   backup  => false,
   notify  => Service[nginx]
 }

  service { 'nginx':
    ensure => running,
    enable => true,
    require => Package['nginx']
  }
}