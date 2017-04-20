# PuppetDB installation
class exittask::db {

  package { 'java-1.8.0-openjdk':
    ensure => installed,
  }

  package {'puppetdb-termini':
    ensure => installed,
  }

  package { 'puppetdb':
    ensure  => installed,
    require => Package['java-1.8.0-openjdk','puppetdb-termini'],
  }

  service { 'puppetdb':
    ensure     => running,
    name       => 'puppetdb',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[puppetdb],
  }
}