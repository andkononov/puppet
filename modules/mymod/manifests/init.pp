class mymod {
  if $::is_puppetmaster == 'true' {
    include mymod::master
  }
  else {
    include mymod::agent
  }
}
