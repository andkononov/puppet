#Install puppet-agent 
class mymod::agent{
exec { 'Register_repo':
      command => 'rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      path    => ['/usr/bin', '/usr/sbin',],
  }
package { 'puppet-agent':
  ensure  => 'latest',
  require => Exec['Register_repo']
  }
service { 'puppet':
  ensure  => 'running',
  require => Package['puppet-agent'],
  }
file { 'Replace_hosts':
  backup  => false,
  source  => '/vagrant/modules/mymod/files/hosts',
  path    => '/etc/hosts',
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
  }
exec { '/etc/puppetlabs/puppet/puppet.conf':
  command     => 'echo "server = puppet-serv.minsk.com" >> /etc/puppetlabs/puppet/puppet.conf',
  path        => ['/usr/bin', '/usr/sbin',],
  require     => Service['puppet'],
  subscribe   => Package['puppet-agent'],
  refreshonly => true
  }

}