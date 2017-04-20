node default {
  notify { "Node ${::fqdn} is up and running!": }
  class {'puppet':}
}
