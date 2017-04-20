# Class: exittask
# ===========================
#
# Full description of class exittask here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'exittask':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#
class exittask inherits exittask::params {

  if $::is_master {
    notify { "${::fqdn} is a puppet server node! Starting server installation...": }
    include exittask::install
    include exittask::config


    if $is_puppetdb {
      include exittask::postgres
      include exittask::pdb

    }

    if $is_puppetexplorer {
      include exittask::explorer

      Class[::exittask::pdb] -> Class[::exittask::explorer]
    }
  }  else {
    notify { "${::fqdn} seems to be a puppet agent. Configuring...": }
    include exittask::config
  }
}
