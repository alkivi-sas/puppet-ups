class ups::config (
  $ups_name         = $ups::ups_name,
  $driver           = $ups::driver,
  $port             = $ups::port,
  $mode             = $ups::mode,
  $admin_user       = $ups::admin_user,
  $admin_password   = $ups::admin_password,
  $upsmon_user      = $ups::upsmon_user,
  $upsmon_password  = $ups::upsmon_password,
  $network_user     = $ups::network_user,
  $network_password = $ups::network_password,
) {
  File {
    ensure => present,
    owner  => 'root',
    group  => 'nut',
    mode   => '0640',
    notify => Service[$ups::params::ups_service_name],
  }

  file { '/etc/nut/ups.conf':
    content => template('ups/ups.conf.erb'),
  }

  file { '/etc/nut/nut.conf':
    content => template('ups/nut.conf.erb'),
  }

  file { '/etc/nut/upsd.conf':
    content => template('ups/upsd.conf.erb'),
  }

  file { '/etc/nut/upsd.users':
    content => template('ups/upsd.users.erb'),
  }

  file { '/etc/nut/upsmon.conf':
    content => template('ups/upsmon.conf.erb'),
  }

  file { '/var/lib/nut/upssched':
    ensure => directory,
    mode   => '0770',
  }

  file { '/etc/nut/upssched.conf':
    content => template('ups/upssched.conf.erb'),
    require => File['/var/lib/nut/upssched'],
  }

  file { '/etc/nut/alert.sh':
    source => 'puppet:///modules/ups/alert.sh',
    mode   => '0755',
  }



  file { '/etc/iptables.d/24-upsd.rules':
    source  => 'puppet:///modules/ups/upsd.rules',
    require => Package['alkivi-iptables'],
    notify  => Service['alkivi-iptables'],
  }
}
