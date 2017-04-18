#setup puppet server
class puppet::server {

  notice ( "servername is ${::hostname}" )
  package { 'puppetserver':
    ensure => 'present',
    require => Yumrepo['puppetlabs'],
  }


  #autosign config
  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('puppet/autosign.conf.erb'),
    mode    => '0644',
  }


  service { 'puppetserver':
    ensure => 'running',
    enable => true,
    require => Package['puppetserver'],
  }
}