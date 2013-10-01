class ups::install () {
  package { $ups::params::ups_package_name:
    ensure => installed,
  }
}
