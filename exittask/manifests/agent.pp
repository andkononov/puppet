class exittask::agent {

#  yumrepo { 'puppetlabs-pc1':
#    ensure   => 'present',
#    baseurl  => 'http://yum.puppetlabs.com/el/7/PC1/$basearch',
#    descr    => 'Puppet Labs PC1 Repository el 7 - $basearch',
#    enabled  => '1',
#    gpgcheck => '1',
#    gpgkey   => 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
#  }

  exec { 'Register_repo':
      command => 'rpm -Uvh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      path    => ['/usr/bin', '/usr/sbin',],
  }
 
  service { 'puppet':
  ensure  => 'running',
  }
  
  host { 'master.epbyminw2695.minsk.epam.com':
  host_aliases => 'puppet',
  ip           => '172.16.1.1',
  }
  
  exec { '/etc/puppetlabs/puppet/puppet.conf':
  command     => 'echo "server = master.epbyminw2695.minsk.epam.com" >> /etc/puppetlabs/puppet/puppet.conf',
  path        => ['/usr/bin', '/usr/sbin',],
  require     => Service['puppet'],
  refreshonly => true
  }
  
  
#  module { 'dwerder/graphite':
#  ensure   => present
#  }

# exec { 'puppet module install dwerder-graphite':
#   path    => '/usr/bin'
# }

}
