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

  # Generate password for different user, will be stored on puppet master only !
  # TODO : this sucks, change that !
  $admin_user = 'admin'
  $admin_password = generate('/usr/bin/sudo', '/root/alkivi-scripts/genpwd', '--save', $admin_user, '--savedir', '/root/.passwd/ups', '--print')

  $upsmon_user = 'upsmon'
  $upsmon_password = generate('/usr/bin/sudo', '/root/alkivi-scripts/genpwd', '--save', $upsmon_user, '--savedir', '/root/.passwd/ups', '--print')

  $network_user = 'upsmon_network'
  $network_password = generate('/usr/bin/sudo', '/root/alkivi-scripts/genpwd', '--save', $network_user, '--savedir', '/root/.passwd/ups', '--print')


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

