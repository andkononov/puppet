class etask::pserv {

package { 'puppetserver':
    source => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
    ensure => present,
  }

file { '/etc/puppetlabs/puppet/autosign.conf':
    ensure  => file,
    content => template('etask/autosign.conf.erb'),
    require     => Package['puppetserver'],
  }

service { 'ensure puppetserver is running':
    ensure => running,
    name   => 'puppetserver',
    enable => true,
    require     => File['/etc/puppetlabs/puppet/autosign.conf'],
  }

}
