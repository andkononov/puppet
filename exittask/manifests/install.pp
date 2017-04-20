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
    require    => Package[puppetserver],
  }

  exec { 'cp -ru /vagrant/modules/exittask /etc/puppetlabs/code/environments/production/modules/':
    path    => ['/usr/bin', 'usr/sbin'],
    onlyif  => [ '[ ! -d /etc/puppetlabs/code/environments/production/modules/exittask ]' ],
  }
}