# Class for installing puppet server and client
# Defined variables for customizing in future
class et {

  # Define variables for installation
  $agn_version = '1.10.0-1.el7'
  $srv_version = '2.7.2-1.el7'
  $rep_url     = 'http://yum.puppetlabs.com/el/7/PC1/x86_64/'
  $gpg_keys    = 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'

  # Including needed repositories to the system
  include et::repository

  if $::is_puppetserver == "true" {
    include et::server
  }
  else {
    include et::client
  }
}
