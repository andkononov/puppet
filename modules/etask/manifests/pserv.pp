class etask::pserv {

host { 'server.minsk.epam.com':
    ensure => present,
    ip     => '192.168.0.5',
  }
host { 'client.minsk.epam.com':
    ensure => present,
    ip     => '192.168.0.2',
  }
package { 'puppetserver':
    source => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
    ensure => present,
  }

file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('etask/autosign.conf.erb'),
    require     => Package['puppetserver'],
  }

service { 'ensure puppetserver is running':
    ensure => running,
    name   => 'puppetserver',
    enable => true,
    require     => File['/etc/puppetlabs/puppet/autosign.conf'],
  }
exec { 'connect to server':
    user        => 'root',
    command     => 'puppet agent --test --server server.minsk.epam.com',
    path        => '/opt/puppetlabs/bin/',
    refreshonly => true,
    require     => Service['ensure puppetserver is running'],
  }

}
