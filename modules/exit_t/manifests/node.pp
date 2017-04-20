#Installiation

class exit_t::node ($state = 'latest' ) {
    package{'puppetlabs-release-pc1-1.1.0-2.el7.noarch':
      ensure   => 'installed',
      provider => 'rpm',
      source   => 'https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm',
      }
    package { 'puppet-agent':
      ensure  => 'latest',
      require => Package['puppetlabs-release-pc1-1.1.0-2.el7.noarch']
      }
    file { '/etc/puppet/puppet.conf':
      ensure  => file,
      content => template('exit_t/puppet.conf.erb'),
      mode    => '0644'
      }
    package { 'puppet-lint':
      ensure   => '1.1.0',
      provider => 'gem',
      }
    service { 'puppet':
      ensure  => 'running',
      enable  => true,
      require => Host['srv'],
      }
    host { 'srv':
      host_aliases => 'puppet-srv.epam.com',
      ip           => '192.168.33.200',
      }
}
