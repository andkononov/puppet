class etask::reg {

  case $::hostname {
    'server': { 

selboolean { 'httpd_can_network_connect':
  name       => httpd_can_network_connect,
  persistent => true,
  value      => on,
}
exec { 'create ssl-keys':
    user        => 'root',
    command     => '/opt/puppetlabs/bin/puppetdb ssl-setup -f',
    refreshonly => true,
    subscribe   => Selboolean['httpd_can_network_connect'],
    notify  => Service['puppetdb'],  
} 

exec { 'connect to server':
    user        => 'root',
    command     => '/opt/puppetlabs/bin/puppet agent --test --server server.minsk.epam.com',
    require => Exec['create ssl-keys'],
} 
     }
     default: { 
exec { 'connect to server':
    user        => 'root',
    command     => '/opt/puppetlabs/bin/puppet agent -t',
} 
     }
  }
}
