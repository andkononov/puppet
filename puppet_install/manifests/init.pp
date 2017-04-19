class puppet_install  {
  
    $baseurl = 'http://yum.puppetlabs.com/el/7/PC1/x86_64/'
    $gpgkey = 'https://yum.puppetlabs.com/RPM-GPG-KEY-puppet https://yum.puppetlabs.com/RPM-GPG-KEY-puppetlabs'
    $autosign_path = '/etc/puppetlabs/puppet/autosign.conf'
    $puppet_agent_ver = '1.10.0-1.el7'
    $puppet_serv_ver = '2.7.2-1.el7'
 

  if $::definition == 'true' {
    include puppet_install::master_inst
  }
  else {
    include puppet_install::agent_inst
  }

}
