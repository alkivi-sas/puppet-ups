class ups::params () {
  case $::operatingsystem {
    /(Ubuntu|Debian)/: {
      $ups_package_name   = 'nut'
      $ups_service_name   = ['nut-client', 'nut-server']
    }
    default: {
      fail("Module ${module_name} is not supported on ${::operatingsystem}")
    }
  }
}

