#initial manifest
#
class exit_t {
  notice ( "Hostname is ${::fqdn}, is_puppetserver? ${::is_puppetserver}" )
  if $::is_puppetserver == 'true' {
     include exit_t::server
  }
  else{
     include exit_t::node
      }
}


