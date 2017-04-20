class exittask::master ($puppet_version = '2.7.2-1.el7') {
 
  exec { 'Register_repo':
      command => 'rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      path    => ['/usr/bin', '/usr/sbin',],
  }  

  notice ( "Hostname is ${::hostname}" )

  host { 'master.epbyminw2695.minsk.epam.com':
  host_aliases => 'puppet',
  ip           => '172.16.10.10',
  }
  
  host { 'agent.epbyminw2695.minsk.epam.com':
  ip           => '172.16.10.20',
  }
  
  package { 'puppetserver':
   ensure => $puppet_version,
  }
  
  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('exittask/autosign.erb'),
    owner   => root,
    group   => root,
    mode    => '0755',
    backup  => false,
    require => Package['puppetserver']
  }
  
  file { '/etc/puppetlabs/code/environments/production/manifests/site.pp':
    ensure  => file,
    content => template('exittask/site.erb'),
    owner   => root,
    group   => root,
    mode    => '0755',
    backup  => false,
    require => Package['puppetserver']
  }
  
#  file { '/etc/puppetlabs/puppet/autosign.conf':
#   ensure  => present,
#   source  => '/vagrant/exittask/autosign.conf',
#   path    => '/etc/puppetlabs/puppet/autosign.conf',
#   owner   => root,
#   group   => root,
#   mode    => '0755',
#   require => Package['puppetserver'],
#  }

  service { 'puppetserver':
  ensure  => 'running',
  require => File['/etc/puppetlabs/puppet/autosign.conf'],
  }

#  exec { 'graphite module':
#      command => '/opt/puppetlabs/bin/puppet module install dwerder-graphite --version 7.0.0',
#      path    => ['/usr/bin', '/usr/sbin',],
#      require => Package['puppetserver']
#  }
}