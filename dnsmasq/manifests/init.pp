class dns{
$ip='8.8.4.4'

package { 'dnsmasq':
  ensure  => '2.66-21.el7',
  }
file { 'Replace_dnsmasq.conf':
  backup  => false,
  source  => 'puppet:///modules/dns/dnsmasq.conf',
  path    => '/etc/dnsmasq.conf',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  notify  => Package['dnsmasq']
  }
file { 'Replace_resolv.conf':
  backup  => false,
  content  => template('dns/resolv.erb'),
  path    => '/etc/resolv.conf',
  owner   => 'root',
  group   => 'root',
  mode    => '0755',
  notify  => Service['dnsmasq']

  }
service { 'dnsmasq':
  ensure  => 'running',
  enable  => true
  }
}
 
