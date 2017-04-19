# Add repository for puppet
# rep_url and gpg_keys defined in init.pp
class puppet::repo {
  Yumrepo { 'puppetlabs':
    ensure   => 'present',
    baseurl  => $::puppet::rep_url,
    gpgkey   => $::puppet::gpg_keys,
    enabled  => '1',
    gpgcheck => '1',
  }
}