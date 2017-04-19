class exittask::agent {

  yumrepo { 'puppetlabs-pc1':
    ensure   => 'present',
    baseurl  => 'http://yum.puppetlabs.com/el/7/PC1/$basearch',
    descr    => 'Puppet Labs PC1 Repository el 7 - $basearch',
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
  }

  host { 'master.epbyminw2695.minsk.epam.com':
  host_aliases => 'puppet',
  ip           => '172.16.1.1',
  }
  
#  module { 'dwerder/graphite':
#  ensure   => present
#  }

exec { 'puppet module install dwerder-graphite':
  path    => '/usr/bin'
}

}
