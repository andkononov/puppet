# node definitions.)

## Active Configurations ##

# Disable filebucket by default for all File resources:
File { backup => false }

# DEFAULT NODE
# Node definitions in this file are merged with node data from the console. See
# http://docs.puppetlabs.com/guides/language_guide.html#nodes for more on
# node definitions.

# The default node definition matches any node lacking a more specific node
# definition. If there are no other nodes in this file, classes declared here
# will be included in every node's catalog, *in addition* to any classes
# specified in the console for that node.

node default {
  # This is where you can declare classes for all nodes.
  # Example:
  #   class { 'my_class': }
  notify { "Node ${::fqdn} is up and running!": }
}

node 'server.m' {
  # # Configure puppetdb
  class { 'puppetdb::server':
    database_host => '127.0.0.1',
    confdir =>  '/etc/puppetlabs/puppetdb/conf.d',
   }
  # Configure the Puppet master to use puppetdb
  class { 'puppetdb::master::config': }
  class { 'puppetexplorer':
    vhost_options => {
      rewrites => [ { rewrite_rule => [
        '^/api/metrics/v1/mbeans/puppetlabs.puppetdb.query.population:type=default,name=(.*)$  https://%{HTTP_HOST}/api/metrics/v1/mbeans/puppetlabs.puppetdb.population:name=$1 [R=301,L]'
      ] } ] }
  }
}