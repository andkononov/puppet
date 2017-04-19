#setup puppet on client
class puppet::client {

  notice ( "clientname is ${::hostname}" )

  package { 'puppet-agent':
    ensure => 'present',
    require => Yumrepo['puppetlabs'],
  }
  service { 'puppet':
    ensure  => 'running',
    enable  => true,
    require => Package['puppet-agent'],
  }
}