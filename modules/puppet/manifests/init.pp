class puppet {
  notice($::is_puppetmaster)

  $rep_url     = 'http://yum.puppetlabs.com/el/7/PC1/x86_64/'
  $gpg_keys    = 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'

  include puppet::repo

  if $::is_puppetmaster == "true" {
    include puppet::server
  }
  else {
    include puppet::client
  }
}