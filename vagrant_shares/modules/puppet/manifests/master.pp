# Class for ensure that puppet server is installed on master
class puppet::master {

# Ensure puppetserver installed 
  package { 'puppetserver':
    ensure  => present,
    require => Yumrepo['puppetlabs']
  }

# Autosign config
  file { 'autosign.conf':
    ensure  => file,
    path    => '/etc/puppetlabs/puppet/autosign.conf',
    content => template('puppet/autosign.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    backup  => false
  }


# Ensure puppetserver running 
  service { 'ensure puppetserver is running':
    ensure  => running,
    name    => 'puppetserver',
    enable  => true,
    require => Package['puppetserver'],
  }
}