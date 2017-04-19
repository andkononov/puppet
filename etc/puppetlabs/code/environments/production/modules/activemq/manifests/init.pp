class activemq {
  # Install
  package {'activemq':
    ensure => latest,
  }

  # Run
  service {'activemq':
    ensure  => running,
    enable  => true,
    require => Package['activemq'],
  }

}
