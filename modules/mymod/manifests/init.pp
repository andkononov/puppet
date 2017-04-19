#init Mymod 
class mymod {

  $puppet_version='2.7.2-1.el7'

  if $::is_puppetmaster == 'true' {
    include mymod::master
  }
  else {
    include mymod::agent
  }
}