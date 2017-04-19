#
#
class exitmodule::node (
  $agent_version = '1.7.0-1.el7',
  $repo_keys     = 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
)
{
  yumrepo { 'puppetlabs-pc1':
    ensure   => 'present',
    baseurl  => 'http://yum.puppetlabs.com/el/7/PC1/$basearch',
    gpgkey   => $repo_keys,
    enabled  => '1',
    gpgcheck => '1'
  }

  package { 'puppet-agent':
    ensure  => $agent_version,
    require => Yumrepo['puppetlabs-pc1']
  }

  service { 'puppet':
    ensure  => 'running',
    enable  => 'true',
    require => Package['puppet-agent']
  }
}