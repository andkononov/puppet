class final_task::apache {

 package { 'httpd':
    ensure => latest
  }
 
 file { '/var/www/html/index.html':
    ensure  => file,
    content => template('final_task/index.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    backup  => false,
  }
       
service { 'httpd':
ensure => running,
enable => true,
require => Package['httpd']
  }
}
