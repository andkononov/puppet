# Class client for setup puppet agent on nodes
# agn_version needed. Could predefive in init.pp
class et::client {
  # Installing puppet agent
  package { 'puppet-agent':
    ensure  => $::et::agn_version,
    require => Yumrepo['puppetlabs'],
  }

  # Enabling puppet
  service { 'puppet':
    ensure  => 'running',
    enable  => true,
    require => Package['puppet-agent'],
  }
}
