class et::client {
  notify {"CLIENT!!! ${::is_puppetserver} ${::hostname} ${::fqdn}":}
}
