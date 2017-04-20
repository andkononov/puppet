node 'server.lab' {
  include activemq
  class { '::mcollective':
    client           => true,
    middleware_hosts => [ 'server.lab' ],
  }  
}

node 'node1.lab' {
  class { '::mcollective':
    client           => true,
    middleware_hosts => [ 'server.lab' ],
  }
}

node 'node2.lab' {
  class { '::mcollective':
    client           => true,
    middleware_hosts => [ 'server.lab' ],
  }
}