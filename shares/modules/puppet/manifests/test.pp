class puppet::test {

  package { 'puppetserver':
    ensure  => installed,
    name    => puppetserver,
    require => Yumrepo['rpm'],
  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure => file,
    source => '/vagrant/modules/puppet/files/autosign.conf',
    notify => Service['puppetserver'],
  }

  file { 'puppet.conf':
    ensure => file,
    path   => '/etc/puppetlabs/puppet/puppet.conf',
    source => '/vagrant/modules/puppet/files/puppet.conf',
    notify => Service['puppetserver'],
  }

  service { 'puppetserver':
    ensure  => 'running',
    enable  => true,
    require => Package['puppetserver'],
      }
}
