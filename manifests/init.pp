# Check pupet server and run class for installation agent or server
#
class final_task {
  if $::is_puppetmaster == true {
    include final_task::puppetserver
  }
  else {
    include final_task::puppetagent
  }
}

