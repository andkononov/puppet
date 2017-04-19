class exittask::master ($puppet_version = '2.7.2-1.el7') {

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

  notice ( "Hostname is ${::hostname}" )

  package { 'puppetserver':
   ensure => $puppet_version,
  }
  
  exec { 'root_bash_profile':
  command   => 'source /root/.bash_profile',
  provider  => shell,
  subscribe => File['/etc/puppetlabs/puppet/autosign.conf'],
  refreshonly => true,
  }

#  file { '/etc/puppetlabs/puppet/autosign.conf':
#    ensure => present,
#    owner   => root,
#    group   => root,
#    mode    => '0644',
#    backup  => false,
#    source => '/vagrant/exittask/autosign.conf',
#    require => Package['puppetserver']
#  }

  file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('exittask/autosign.erb'),
    owner   => root,
    group   => root,
    mode    => '0755',
    backup  => false,
    require => Package['puppetserver']
  }

  service { 'puppetserver':
  ensure  => 'running',
  require => File['/etc/puppetlabs/puppet/autosign.conf'],
  }
}
