class mymod::agent{

exec { 'Register_repo':
      command => "rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm",
      path => ['/usr/bin', '/usr/sbin',],
  }

 package { 'puppet-agent':
  ensure => 'latest',
  require => Exec['Register_repo']
  }
  
service { 'puppet':
  ensure  => 'running',
  require => Package['puppet-agent'],
  }
  
exec { 'hosts':
     command => 'echo "192.168.10.30 puppet-serv.minsk.com" >> /etc/hosts',
     path => ['/usr/bin', '/usr/sbin',],
      }
     
      
exec { '/etc/puppetlabs/puppet/puppet.conf':
      command => 'echo "server = puppet-serv.minsk.com" >> /etc/puppetlabs/puppet/puppet.conf',
      path => ['/usr/bin', '/usr/sbin',],
      require => Service['puppet']
    }
  
}
