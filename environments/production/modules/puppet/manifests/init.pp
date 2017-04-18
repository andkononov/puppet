class puppet{
  if $facts['is_puppetmaster'] {
    notify { "Node ${::fqdn} is master!": }
    
    package { 'puppetserver':
      ensure => 'installed',
    }

    file { "${settings::confdir}/autosign.conf":
      ensure  => 'file',
      source  => 'puppet:///modules/puppet/autosign.conf',
    }

    class { 'puppetdb':
      ssl_deploy_certs => true,
      listen_address => '0.0.0.0',
    }
    # Configure the Puppet master to use puppetdb
    class { 'puppetdb::master::config': }
    class {'puppetexplorer':
    vhost_options => {
      rewrites  => [ { rewrite_rule => ['^/api/metrics/v1/mbeans/puppetlabs.puppetdb.query.population:type=default,name=(.*)$  https://%{HTTP_HOST}/api/metrics/v1/mbeans/puppetlabs.puppetdb.population:name=$1 [R=301,L]'] } ] }
    }
  }
    
}
