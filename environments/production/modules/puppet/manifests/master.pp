class puppet::master {

    package { 'puppetserver':
      ensure => 'installed',
      notify => Exec['run master']
    }

    file { "${settings::confdir}/autosign.conf":
      ensure  => 'file',
      source  => 'puppet:///modules/puppet/autosign.conf',
      require => Package['puppetserver'],
    }

   # Important!
   # Puppet server should be runed BEFORE applying 'puppetdb::master::config' class in order to
   # generate certificates

   # Used exec statement instead of 'serive' to start the service immediately

    exec { 'run master':
      command => 'puppet resource service puppetserver ensure=running',
      refreshonly => true,
      path => '/opt/puppetlabs/bin/',
    }

    class { 'puppetdb':
      listen_address => '0.0.0.0',
      open_listen_port => true,
    }

    class { 'puppetdb::master::config': 
    }

    class {'puppetexplorer':
    vhost_options => {
      rewrites  => [ { rewrite_rule => ['^/api/metrics/v1/mbeans/puppetlabs.puppetdb.query.population:type=default,name=(.*)$  https://%{HTTP_HOST}/api/metrics/v1/mbeans/puppetlabs.puppetdb.population:name=$1 [R=301,L]'] } ] },
      require => Class['puppetdb::master::config']
    }
    
    $reports = true

    file { "${settings::confdir}/puppet.conf":
      content => template('puppet/puppet.erb'),
      mode    => '0644',
      notify  => Service['puppetserver']
    }

}
