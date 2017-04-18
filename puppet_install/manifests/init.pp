class puppet_install {

  if $::definition == 'true' {
    include puppet_install::master_inst
  }
  else {
    include puppet_install::agent_inst
  }

}
