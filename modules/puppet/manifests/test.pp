# Install puppet server
class puppet::test {

  # Install puppet server
  package { 'puppetserver':
    ensure  => installed,
    name    => puppetserver,
    require => Yumrepo['rpm'],
  }

  # Add autosign.conf
  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure => file,
    source => '/vagrant/modules/puppet/files/autosign.conf',
    notify => Service['puppetserver'],
  }

  # Add puppet.conf
  file { 'puppet.conf':
    ensure => file,
    path   => '/etc/puppetlabs/puppet/puppet.conf',
    source => '/vagrant/modules/puppet/files/puppet.conf',
    notify => Service['puppetserver'],
  }

  # start puppet-server service
  service { 'puppetserver':
    ensure  => 'running',
    enable  => true,
    require => Package['puppetserver'],
      }
}
