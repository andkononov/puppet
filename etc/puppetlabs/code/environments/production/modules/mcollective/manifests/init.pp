class mcollective {
  # Install
  package {'mcollective':
    ensure => latest,
  }

  # Run
  service {'mcollective':
    ensure  => running,
    enable  => true,
    require => Package['mcollective'],
  }

  Package['mcollective'] -> Mcollective::Setting <| |> ~> Service['mcollective']

}

define mcollective::setting ($setting = $title, $target = '/etc/mcollective/server.cfg', $value) {
  validate_re($target, '\/(plugin\.d\/[a-z]+|server)\.cfg\Z')
  $regex_escaped_setting = regsubst($setting, '\.', '\\.', 'G') # assume dots are the only regex-unsafe chars in a setting name.

  file_line {"mco_setting_${title}":
    path  => $target,
    line  => "${setting} = ${value}",
    match => "^ *${regex_escaped_setting} *=.*$",
  }
}
