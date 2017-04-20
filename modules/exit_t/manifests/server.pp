#Installiation

class exit_t::server ($state = 'latest' ) {
    package{'puppetlabs-release-pc1-1.1.0-2.el7.noarch':
      ensure   => 'installed',
      provider => 'rpm',
      source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      }
    package { 'puppetserver':
      ensure  => 'latest',
      }
    package { 'puppet-lint':
      ensure   => '1.1.0',
      provider => 'gem',
      }
    exec { 'reloadprofile':
      command  => 'source /etc/profile',
      require  => Package['puppetserver'],
      provider => shell,
      }
    file { '/etc/puppetlabs/puppet/autosign.conf':
      ensure  => file,
      content => template('exit_t/autosign.conf.erb'),
      mode    => '0644'
      }
    service { 'puppetserver':
      ensure  => 'running',
      enable  => true,
      require =>  [ Exec['reloadprofile'], File['/etc/puppetlabs/puppet/autosign.conf'] ],
      }
}
