# Install puppet server
class puppet::server {

  # Install puppet server
  package { 'puppetserver':
    ensure  => installed,
    name    => puppetserver,
    require => Yumrepo['rpm'],
  }

  # Add autosign.conf
  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('puppet/autosign.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    backup  => false,
  }

  # Add puppet.conf
  exec {'alias':
    command => 'echo "dns_alt_names = puppet" >> /etc/puppetlabs/puppet/puppet.conf',
    path    => ['/usr/bin', '/usr/sbin',],
    subscribe   => File['/etc/puppetlabs/puppet/autosign.conf'],
    refreshonly => true,
  }

  # start puppet-server service
  service { 'puppetserver':
    ensure  => 'running',
    enable  => true,
    require => Package['puppetserver'],
  }
}
