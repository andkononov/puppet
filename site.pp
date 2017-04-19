# install current version of puppet

node server.bm {
	include 'puppet'
}

node default {
  include 'puppet'
  class {'puppet::caddy':
    
  }
}
