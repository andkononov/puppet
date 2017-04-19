node 'server.lab' {
	
  include activemq
  include mcollective

}

node 'node.lab' {

  include mcollective::client

}
