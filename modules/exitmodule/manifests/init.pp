class exitmodule {
  if $::is_puppetmatser == 'true' {
    include exitmodule::master
  }
  else {
    include exitmodule::node
  }
}
