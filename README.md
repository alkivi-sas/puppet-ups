# NUT and UPSD Module

This module will install and configure a nut server and a nut client.

## Usage

### Minimal server configuration

```puppet
class { 'ups': 
  manufacturer =>  'dell',
  method       =>  'usb',
  ups_name     =>  'alkivi-ups',
  mode         =>  'netserver',
  upsmon_mode  =>  'master',
  motd         =>  true,
}
```
This will do the typical install, configure and service management.
So far, only dell ups with usb driver are supported.
Adding other device should not be hard, all you need to do is find the associated driver (dell + usb = usbhid-ups)

Password generation sucks so far, it's handle on the puppet master. I need to change that

## Limitations

* This module has been tested on Debian Wheezy, Squeeze.

## License

All the code is freely distributable under the terms of the LGPLv3 license.

## Contact

Need help ? contact@alkivi.fr

## Support

Please log tickets and issues at our [Github](https://github.com/alkivi-sas/)
