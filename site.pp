node 'server.lab' {
  include activemq
  class { '::mcollective':
    client           => true,
    middleware_hosts => [ 'server.lab' ],
  }  
}

node 'node.lab' {
  class { '::mcollective':
    client           => true,
    middleware_hosts => [ 'server.lab' ],
  }
}

