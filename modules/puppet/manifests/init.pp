# install puppet

class puppet (String $proxy_url = 'google.com'){

  #$port = '2040'


  $rep_url  = 'http://yum.puppetlabs.com/el/7/PC1/x86_64/'
  $gpg_keys = 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'

  if $::is_pappetmaster == 'true' {
    include puppet::common
    include puppet::server
  }
  else {
    include puppet::common
    include puppet::agent
  #  include puppet::caddy
  }
}


