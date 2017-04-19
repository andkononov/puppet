class exitmodule::master (
  $server_version = '2.6.0-1.el7',
  $repo_keys      = 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
)
{
  yumrepo { 'puppetlabs-pc1':
    ensure   => 'present',
    baseurl  => 'http://yum.puppetlabs.com/el/7/PC1/$basearch',
    gpgkey   => $repo_keys,
    enabled  => '1',
    gpgcheck => '1'
  }
  
  package { 'puppetserver':
    ensure  => $server_version,
    require => Yumrepo['puppetlabs-pc1']
  }

  file { '/etc/sysconfig/puppetserver':
    ensure  => file,
    content => template('exitmodule/puppet.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    backup  => false,
    require => Package['puppetserver']
  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('exitmodule/autosign.erb'),
    owner   => root,
    group   => root,
    mode    => '0644',
    backup  => false
  }

  service { 'puppetserver':
    ensure  => 'running',
    enable  => 'true',
    require => File['/etc/puppetlabs/puppet/autosign.conf']
  }
}
