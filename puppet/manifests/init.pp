class puppet {

  if $::definition == 'true' {
    include puppet::master_inst
  }
  else {
    include puppet::agent_inst
  }

}
