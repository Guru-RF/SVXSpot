# SVXSpot an SVXLink Analog Hotspot for the Raspberry Pi Zero 

[RF.Guru Analog Hotspot 70CM (UHF)](https://shop.rf.guru/products/2023-p-041-u) 500mW Power

[RF.Guru Analog Hotspot 2M (VHF)](https://shop.rf.guru/products/2023-p-041-v) 500mW Power

[RF.Guru Analog Transceiver 70CM (UHF)](https://shop.rf.guru/products/2023-p-141-u) 1.3W Power (added a Low Pass filter) needs additinal power best used with an external power source like [RF.Guru 
 Pi Zero PSU](https://shop.rf.guru/products/2021-p-053)

[RF.Guru Analog Transceiver 2M (VHF)](https://shop.rf.guru/products/2023-p-141-v) 1.3W Power (added a Low Pass filter) needs additinal power best used with an external power source like [RF.Guru 
 Pi Zero PSU](https://shop.rf.guru/products/2021-p-053)

**Used PIN's:**
 - 3 **GPIO2** 
 - 6 **GPIO3** 
 - 35 **GPIO19** 
 - 8 **TX** 
 - 10 **RX**
 - 12 **CLK** 
 - 32 **GPIO12** -> ***COS input*** from the radio chip 
 - 36 **GPIO16** -> ***PTT*** pin 
 - 38 **GPIO20** 
 - 40 **GPIO2**

These boards are also suitable for conducting analog ham radio experiments within the 70cm and 2m ham radio frequency bands. (Like APRS iGate/Digipeater, packet etc...)

# Antenna

The hotspot is not suitable for connecting an outdoor antenna because it lacks a sufficient low-pass filter. However, the transceiver version is equipped with a low-pass filter and is suitable for transmitting via an outdoor antenna.

The RF 50 ohm output requires an antenna with a SWR (Standing Wave Ratio) of less than 4:1, which is considered reasonable. If you experience sound distortion, it could indicate that the antenna being used has a high SWR, leading to common-mode currents that may affect the RF chip. To test, use a 50-ohm dummy load (for UHF) and consider using a more suitable antenna. We recommend and sell antennas that work without any issues.

# Barebone

If you prefer to handle everything manually, you can find the necessary resources here:

- RF Module (SA818) can be programmed via [https://github.com/Guru-RF/SA818](https://github.com/Guru-RF/SA818).
- The I2C audio chip kernel module can be found here [https://github.com/waveshare/WM8960-Audio-HAT](https://github.com/waveshare/WM8960-Audio-HAT).

# SVXLink Bookworm Image

[Bookworm Image 2024-09-09](https://storage.googleapis.com/rf-guru/rpi-images/hotspot-2024-09-09.img.gz) (only for Raspberry Pi Zero 2W, Raspberry Pi 4 and Raspberry Pi 5)

*The firmware version released on 2024-09-09 now handles CTCSS decoding through software. Previously, some users encountered a significant bug in the FM chip’s CTCSS decoding, leading to random false detections. If you’re using an earlier version, we strongly recommend upgrading!*

*This firmware now includes talk group mapping to CTCSS tones, making it much easier to switch between talk groups. It also works for radios without DTMF macros! The TX CTCSS tone remains fixed across all talk groups, while the RX tone is variable and can be configured through the mapping settings in the configurator, the TX tone (fixed for all talkgroups) is also configurable in the configurator.*

Utilize PI-Imager to write the image to your MicroSD card! **Don't use svxlink or svxspot as a username, these are system usernames, using them will result in a broken installation !**

You can set username/password and wifi credentials in the Raspberry PI Imager tool ... there is no default username/password !

Use the latest release of PI-Imager [Github](https://github.com/raspberrypi/rpi-imager/releases)

[Youtube demonstration of how to use PI-Imager on Windows 11](https://www.youtube.com/watch?v=mOqekYMIBgU)

[Youtube demonstration of how to use PI-Imager on MacOS X](https://www.youtube.com/watch?v=UeiBUUef2c0)

Boot the hotspot with a descent power supply that can provide enough current and has a stable voltage > 5v !

It appears that the Raspberry Pi freezes after resizing the file system. Currently, after the initial boot, wait for 10 minutes, disconnect the power, and then restart. We suspect this issue is a bug and anticipate it will likely be resolved in a future release of pi-shrink.

To complete the final configuration step, you can connect via the dashboard by browsing to your hotspots ip (http://<hotspot-ip>). Chooce shell for shell access !

Once logged in, you can execute:
```console
sudo hotspot-config
```
as illustrated in this video:

https://github.com/Guru-RF/SVXSpot/assets/1251767/e36c240f-1fa5-447f-9a3a-93d46a942cdd

# SVXLink quick mini HOW-TO

The chip has a deviation of 5khz ... for best audio experience send with Wide FM (FM), it will sound better/you will sound better !

To activate a talk group, simply send the corresponding CTCSS tone from the mapping while in TG0 (you'll hear the bleep tone 15 seconds after a QSO). This will instantly open the talk group—no need for double presses like before. In other words, you can start speaking right away!

To get the current ip address send DTMF D911#

To set up multiple talk groups for monitoring, configure them within the 'hotspot-config' using this format: 8++, 23+, 50, 51, 52, 53, 54, 55. Note that the TX CTCSS tone for the hotspot remains the same across all talk groups.

The plus signs denote priority levels.

Talk group mapping via CTCSS: <tone>:<talkgroup>,<tone>:<talkgroup>,....

example (default): 67.0:8400,69.3:8,71.9:23,74.4:9000,77.0:50,79.7:51,82.5:52,85.4:53,88.5:54,91.5:55

The hotspot also has a local portal you can access it via it's hostname if you network support this or via his ip adress.

# Configuring additional WiFi

For adding additional (wifi) networks you can use the
```console
sudo nmtui 
```
provided by the Pi OS.

Do not remove AccessPopup !! It takes about 2 minutes to switch from WiFi network ... so please be patient !

Avoid configuring static IPs on the WiFi, as it can disrupt the operation of Accesspopup.

<img width="782" alt="nmtui" src="https://github.com/user-attachments/assets/32490ef3-aaf6-4c4b-8b21-600d9671a287">

# Choosing a frequency and ctcss tone

We advice a frequency not in use by nearby repeaters, also do not use ISM frequency 433Mhz ... we use 439.100 on 70cm and 145.250 on 2m

For CTCSS tone ... use a tone not localy used ... we use 88.5

# Modify talk groups on the dashboard

Edit the following file for base talkgroups:
```console
sudo vi /var/www/html/include/tgdb.php
```

Edit the following file for talkgroup buttons:
```console
sudo vi /var/www/html/include/config.inc.php
```

# Accesspopup

[accesspopup](https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/203-automated-switching-accesspoint-wifi-network) is installed by default, if no WiFi network is reachable it will automaticaly presents itselves as an acccess point where you can connect to.

SSID Accesspopup with passwd 1234567890
Default IP Hotspot in AccessPopup is [http://192.168.50.5/](http://192.168.50.5/)

When switching networks (without reboot) it can take up to 2 minutes for the pi to reconnect to a known network !
2 minutes is quite long ... so please have patience !!!

Avoid configuring static IPs on the WiFi, as it can disrupt the operation of Accesspopup !

To disable accesspupup
```console
sudo systemctl disable AccessPopup.timer
sudo reboot
```

To re-enable accesspup
```console
sudo systemctl enable AccessPopup.timer
sudo reboot
```

# iPhone Personal Hotspot

You need to go to Personal Hotspot setting until the hotspot is connected, there is no option on the iPhone/iPad to have the SSID beeing broadcasted all the time.
Once connected it works like a charm.

# Hotspot with enclosure

https://github.com/Guru-RF/SVXSpot/assets/1251767/5cdcc10a-c380-4bc6-8c2b-18d2c6e67908

# Manual SVXLink and Radiomodule install scripts

(not needed when using the image, this is preinstalled on the image)

Prepare your sd-card with Raspberry PI OS ([Bookworm 32Bit Lite](https://www.raspberrypi.com/software/operating-systems/)) ([Youtube](https://www.youtube.com/watch?v=vxmO_a5WNI8))

Login to your system with ssh add run following commands:

### Install GIT  ###
```console
sudo apt -y install git
```

### Clone repostory ###
```console
git clone https://github.com/Guru-RF/SVXSpot.git
```

### Audio and Radio module installation script ###
```console
cd SVXSpot
sudo bash install-radiomodule.sh
```

### SVXLink installation script ###
```console
cd SVXSpot
sudo bash install-svxlink.sh
```

### Tuning Input Volume ###
(modify /usr/sbin/hotspot_volume to the desired volume)
```console
systemctl stop svxlink
/sbin/hotspot_volume
arecord -V stereo -r 44100 -f S16_LE -c 2 /dev/null
```

### Modify RF Module settings
(modify /usr/sbin/hotspot for rf module changes)

### Simple Test ###
Sending D1# dtmf on the configured frequency starts the parrot.<br>
(On Anytone DTMF ABCD -> P1 = A  P2 =B  up button =C down button =D)

### Hostpot Full Audio / RF module Test ###
```console
curl -L -o - https://raw.githubusercontent.com/Guru-RF/SVXSpot/master/test-hotspot.sh | sudo bash
```

### SVXLink Hotspot in action ###
https://github.com/Guru-RF/SVXSpot/assets/1251767/50dd4366-8439-4067-83b5-5866d0adca77
