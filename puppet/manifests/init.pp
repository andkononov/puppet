class puppet {

  if $::definition {
    include puppet::master_inst
  }
  else {
    include puppet::agent_inst
  }

}
