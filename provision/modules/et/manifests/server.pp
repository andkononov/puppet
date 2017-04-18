# Class server for setup puppetserver on nodes
# srv_version needed. Could predefive in init.pp
class et::server {
  # Installing server
  package { 'puppetserver':
    ensure  => $::et::srv_version,
    require => Yumrepo['puppetlabs']
  }

  # Autosign config
  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('et/autosign.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    backup  => false
  }

  # Enable service
  service { 'puppetserver':
    ensure  => 'running',
    enable  => true,
    require => Package['puppetserver'],
  }
}
