#Install puppet-server
class mymod::master{
exec { 'Register_repo':
  command => 'rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
  path    => ['/usr/bin', '/usr/sbin',],
  }
 package { 'puppetserver':
  ensure => 'latest',
  }
file { '/etc/puppetlabs/puppet/autosign.conf':
  ensure  => file,
  content => template('mymod/autosign.erb'),
  owner   => root,
  group   => root,
  mode    => '0755',
  require => Package['puppetserver']
  }
service { 'puppetserver':
  ensure  => 'running',
  require => File['/etc/puppetlabs/puppet/autosign.conf'],
  }
}