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

# SVXLink Bookworm Image #

[Bookworm 32Bit Lite 2024-01-29 Image](https://storage.googleapis.com/rf-guru/rpi-images/hotspot-2024-01-29.img.gz) (only for Raspberry Pi Zero 2W, Raspberry Pi 4 and Raspberry Pi 5)

Utilize PI-Imager to write the image to your MicroSD card! **Don't use svxlink or svxspot as a username, these are system usernames, using them will result in a broken installation !**

Use the latest release of PI-Imager [Github](https://github.com/raspberrypi/rpi-imager/releases)

[Youtube demonstration of how to use PI-Imager on Windows 11](https://www.youtube.com/watch?v=mOqekYMIBgU)

[Youtube demonstration of how to use PI-Imager on MacOS X](https://www.youtube.com/watch?v=UeiBUUef2c0)

Boot the hotspot with a descent power supply that can provide enough current and has a stable voltage > 5v !

It appears that the Raspberry Pi freezes after resizing the file system. Currently, after the initial boot, wait for 10 minutes, disconnect the power, and then restart. We suspect this issue is a bug and anticipate it will likely be resolved in a future release of pi-shrink.

To complete the final configuration step, SSH is required. For Linux/Mac, SSH is installed by default. Open a terminal and type ssh username@ip. However, for Windows, you'll need an additional application, such as Putty.

[Youtube how to install putty on Windows 11](https://www.youtube.com/watch?v=ljL4Wvv8XwI)

Ensure that you download Putty for the correct architecture; for the majority, it will be x86 64-bit.

Once connected, you can execute:
```console
sudo hotspot-config
```
as illustrated in this video:

https://github.com/Guru-RF/SVXSpot/assets/1251767/e36c240f-1fa5-447f-9a3a-93d46a942cdd

To activate the default talk group, just press PTT once, the second PTT will go to the network.

The chip has a deviation of 2.5khz ... for best audio experience send with Narrow FM (FM-N), it will sound better !

To activate another talk group send DTMF 91 talkgroup #

To leave the active talk group send DTMF 91 0 #

To specify various talkgroups for monitoring within the 'hotspot-config', you can indicate them as follows: 8++,23+,50,51,52,53,54,55 

The plus signs denote priority levels.

The hotspot also has a local portal you can access it via it's hostname if you network support this or via his ip adress.

For adding additional networks you can use the
```console
sudo nmtui 
```
provided by the Pi OS.

# Choosing a frequency and ctcss tone

We advice a frequency not in use by nearby repeaters, also do not use ISM frequency 433Mhz ... we use 439.100 on 70cm and 145.250 on 2m

For CTCSS tone ... use a tone not localy used ... we use 88.5

# PI OS full upgrade procedure

For upgrading the PI use:
```console
sudo apt -y update && sudo apt -y full-upgrade
```
If dac/adc kernel module is absent after upgrade, you can check this with:
```console
sudo aplay -a
```
It should list a soundcard if this is not the case ... PI OS broke it and we need to manualy reinstall te soundcard module !
```console
git clone https://github.com/waveshare/WM8960-Audio-HAT
cd WM8960-Audio-HAT/
sudo ./install.sh
reboot
```

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
