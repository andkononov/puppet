# Class for ensure that puppet agent is installed on nodes
class puppet::agent {

# Ensure puppet agent installed
  package { 'puppet-agent':
    ensure  => present,
    require => Yumrepo['puppetlabs'],
  }

# Puppet config
  file { 'puppet.conf':
    ensure  => file,
    path    => '/etc/puppetlabs/puppet/puppet.conf',
    content => template('puppet/puppet.conf.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    backup  => false,
    require => Package['puppet-agent'],
  }

# Ensure puppet is running
  service { 'puppet':
    ensure  => 'running',
    name    => 'puppet',
    enable  => true,
    require => File['puppet.conf'],
  }
}

