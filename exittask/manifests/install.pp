# Installs puppet
class exittask::install {

  package { 'puppetserver':
    ensure => installed,
  }

  service { 'puppetserver':
    ensure     => running,
    name       => 'puppetserver',
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}