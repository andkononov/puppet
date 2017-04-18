# Add repository to the systemc
# rep_url and gpg_keys defined in init.pp
class et::repository {
  yumrepo { 'puppetlabs':
    ensure   => 'present',
    baseurl  => $::et::rep_url,
    gpgkey   => $::et::gpg_keys,
    enabled  => '1',
    gpgcheck => '1'
  }
}