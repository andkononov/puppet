#Checking installiation to do
#based on custom servercheck fact
class final::work ($state = 'latest' ) {
  if $::servercheck == 'true' {
    notice ( "Hostname is ${::fqdn}, is_puppetserver? ${::is_puppetserver}" )
    package{'puppetlabs-release-pc1-1.1.0-2.el7.noarch':
      ensure   => 'installed',
      provider => 'rpm',
      source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      }
    package { 'puppetserver':
      ensure  => $state,
      require => Package['puppetlabs-release-pc1-1.1.0-2.el7.noarch'],
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
      content => template('/vagrant/exittask/templates/autosign.erb'),
      owner   => root,
      group   => root,
      mode    => '0644'
      }
    service { 'puppetserver':
      ensure  => 'running',
      require =>  [ Exec['reloadprofile'], File['/etc/puppetlabs/puppet/autosign.conf'] ],
      }
  }
  else {
    notice ( "Hostname is ${::fqdn}, is_puppetserver? ${::is_puppetserver}" )
    package{'puppetlabs-release-pc1-1.1.0-2.el7.noarch':
      ensure   => 'installed',
      provider => 'rpm',
      source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      }
    package { 'puppet-agent':
      ensure  => 'latest',
      require => Package['puppetlabs-release-pc1-1.1.0-2.el7.noarch'],
      }
    package { 'puppet-lint':
      ensure   => '1.1.0',
      provider => 'gem',
      }
    service { 'puppet':
      ensure  => 'running',
      require => Host['srv'],
      }
    host { 'srv':
      host_aliases =>  'srv.minsk.epam.com',
      ip           => '192.168.100.100',
      }
  }
}
