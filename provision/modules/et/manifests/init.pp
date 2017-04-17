class et {
  if $::is_puppetserver == 'true'{
    include et::server
  }
  else{
    include et::client
  }
}