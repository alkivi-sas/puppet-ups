class ups::service () {
  service { $ups::params::ups_service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}

