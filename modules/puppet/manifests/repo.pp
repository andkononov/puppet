#add repo for puppet
class puppet::repo {
  yumrepo { 'puppetlabs':
    ensure   => 'present',
    descr    => 'Puppet Labs Repository',
    baseurl  => $::puppet::rep_url,
    enabled  => '1',
    gpgcheck => '1',
    gpgkey   => $::puppet::gpg_keys
  }
}