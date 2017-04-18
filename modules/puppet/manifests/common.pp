# Add current repo
class puppet::common {
  yumrepo { 'rpm':
    ensure   => 'present',
    baseurl  => $::puppet::rep_url,
    gpgkey   => $::puppet::gpg_keys,
    enabled  => '1',
    gpgcheck => '1',
  }
}

