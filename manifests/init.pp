class ups (
  $manufacturer = 'dell',
  $method       = 'usb',
  $ups_name     = 'alkivi-ups',
  $mode         = 'netserver',
  $upsmon_mode  = 'master',
  $motd         = true,
) {


  if($manufacturer == 'dell')
  {
    if($method == 'usb')
    {
      $driver = 'usbhid-ups'
      $port   = 'auto'
    }
  }

  if($motd)
  {
    motd::register{"UPS ${manufacturer} support": }
  }

  $admin_user   = 'admin'
  $upsmon_user  = 'upsmon'
  $network_user = 'upsmon_network'

  $admin_password   = alkivi_password($admin_user, 'ups')
  $upsmon_password  = alkivi_password($upsmon_user, 'ups')
  $network_password = alkivi_password($network_user, 'ups')

  alkivi_base::passwd{ 'ups_admin_user':
    file => $admin_user,
    type => 'ups'
  }

  alkivi_base::passwd{ 'ups_upsmon_user':
    file => $upsmon_user,
    type => 'ups'
  }

  alkivi_base::passwd{ 'ups_network_user':
    file => $network_user,
    type => 'ups'
  }


  # declare all parameterized classes
  class { 'ups::params': }
  class { 'ups::install': }
  class { 'ups::config': }
  class { 'ups::service': }

  # declare relationships
  Class['ups::params'] ->
  Class['ups::install'] ->
  Class['ups::config'] ->
  Class['ups::service']
}

