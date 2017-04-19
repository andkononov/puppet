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

}
