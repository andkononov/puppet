class exitmodule {
  if $::is_puppetmaster == 'true' {
    include exitmodule::master
  }
  else {
    include exitmodule::node
  }
}
