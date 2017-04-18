class puppet{
  if $facts['is_puppetmaster'] {
    notify { "Node ${::fqdn} is master!": }
    
    package { 'puppetserver':
      ensure => 'latest',
    }

    file { "${settings::confdir}/autosign.conf":
      ensure  => 'file',
      source  => 'puppet:///modules/puppet/autosign.conf',
      require => Package['puppetserver'],
    }

    service { 'puppetserver':
      ensure => 'running',
      enable => true,
      require => File["${settings::confdir}/autosign.conf"]
    }

    class { 'puppetdb':
      listen_address => '0.0.0.0',
      open_listen_port => true,
      require => Service['puppetserver']
    }

    class { 'puppetdb::master::config': 
        enable_reports => true,
    }
    
    class {'puppetexplorer':
    vhost_options => {
      rewrites  => [ { rewrite_rule => ['^/api/metrics/v1/mbeans/puppetlabs.puppetdb.query.population:type=default,name=(.*)$  https://%{HTTP_HOST}/api/metrics/v1/mbeans/puppetlabs.puppetdb.population:name=$1 [R=301,L]'] } ] },
      require => Class['puppetdb::master::config']
    }
  }
    
}
