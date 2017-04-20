class puppet{
  if $facts['is_puppetmaster'] {
    notify { "Node ${::fqdn} is master. Installing...": }
    include puppet::master
  }
  else {
    notify { "Node ${::fqdn} is agent. Installing...": }
    include puppet::agent
  }
}
