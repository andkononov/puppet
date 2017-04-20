class final::syslog ($state = 'latest' ) {
  if $::is_puppetserver == 'true' {
    notice ( "Master Host ${::fqdn} receives logs /var/log/agent.log" )
    service { 'rsyslog':
      ensure  => 'running',
      enable  => true
      }
    file { '/etc/rsyslog.conf':
      ensure  => file,
      notify  => Service['rsyslog']
      content => template('final/rsyslog_srv.erb'),
      owner   => root,
      group   => root,
      mode    => '0644'
      }
  }
  else {
    notice ( "Client Host ${::fqdn} collects logs" )
    service { 'rsyslog':
      ensure  => 'running',
      enable  => true
      }
    file { '/etc/rsyslog.conf':
      ensure  => file,
      notify  => Service['rsyslog']
      content => template('final/rsyslog_agent.erb'),
      owner   => root,
      group   => root,
      mode    => '0644'
      }
   service { 'systemd-journald':
      ensure  => 'running',
      enable  => true
      }
    file { '/etc/systemd/journald.conf':
      ensure  => file,
      notify  => Service['systemd-journald']
      content => template('final/journald.erb'),
      owner   => root,
      group   => root,
      mode    => '0644'
      }
     }
}
