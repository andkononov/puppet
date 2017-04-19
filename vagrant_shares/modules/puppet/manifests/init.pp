# Class: puppet
# ===========================
#
# Author Name <mikalai_kuzniatsou@epam.com>
#
# Copyright 2017 Mikalai Kuzniatsou, unless otherwise noted.


class puppet {

# Variables
# ----------
  $rep_url     = 'http://yum.puppetlabs.com/el/7/PC1/x86_64/'
  $gpg_keys    = 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'

# Including repositories
  include puppet::repo

# Main logic
# ----------
  if $::is_puppetserver {
    notice ('installing puppet-SERVER')
    include puppet::master
  }
  else {
    notice ('installing puppet-AGENT')
    include puppet::agent
  }
}