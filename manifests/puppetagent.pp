class final_task::puppetagent ($version_agent = 'latest' ) {

#  package { 'puppet-repo':
#    ensure   => installed,
#    provider => rpm,
#    source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm'
#  }
  yumrepo { 'puppetlabs-pc1':
    ensure   => 'present',
    baseurl  => 'http://yum.puppetlabs.com/el/7/PC1/$basearch',
    enabled  => '1',
  }

  #package { 'puppet-agent':
  #  ensure  => $version_agent,
  #  require => Yumrepo['puppetlabs-pc1'],
  #}

  service { 'puppet':
    ensure  => 'running',
    require => Yumrepo['puppetlabs-pc1'],
  }
}



