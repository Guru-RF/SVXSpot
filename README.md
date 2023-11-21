# SVXSpot an SVXLink Analog Hotspot 70CM (UHF) for the Raspberry Pi Zero ([RF.Guru SVXSpot](https://rf.guru/2023-k-041))

[RF.Guru Analog Hotspot 70CM (UHF)](https://rf.guru/2023-k-041) (Currently for sale)

[RF.Guru Analog Hotspot 2M (VHF)](https://rf.guru/) (In development)

These boards are also suitable for conducting analog ham radio experiments within the 70cm and 2m ham radio frequency bands.

# SVXLink Bookworm Image #

[Bookworm 32Bit Lite 2023-11-11](https://storage.googleapis.com/rf-guru/rpi-images/hotspot-2023-11-11.img.gz)
New image with hotspot-config will be available later today !

Utilize PI-Imager for image burning (Operating System -> Custom), input user and WiFi credentials, and activate SSH access (select the gear icon)!!!

[Youtube demonstration of how to use PI-Imager](https://www.youtube.com/watch?v=UeiBUUef2c0)

It appears that the Raspberry Pi freezes after resizing the file system. Currently, after the initial boot, wait for 5 minutes, disconnect the power, and then restart. We suspect this issue is a bug and anticipate it will likely be resolved in a future release of pi-shrink.

To complete the final configuration step, SSH is required. For Linux/Mac, SSH is installed by default. Open a terminal and type ssh username@ip. However, for Windows, you'll need an additional application, such as Putty.

[Youtube how to install putty on Windows 11](https://www.youtube.com/watch?v=ljL4Wvv8XwI)

Ensure that you download Putty for the correct architecture; for the majority, it will be x86 64-bit.

Once connected, you can execute "sudo hotspot-config" as illustrated in this video:

https://github.com/Guru-RF/SVXSpot/assets/1251767/17f0ab74-1131-41cb-9010-6faa3e3f832c

# Manual SVXLink and Radiomodule install scripts

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
(modify hotspot_volume to the desired volume)
```console
systemctl stop svxlink
/sbin/hotspot_volume
arecord -V stereo -r 44100 -f S16_LE -c 2 /dev/null
```

### Simple Test ###
Sending D1# dtmf on the configured frequency starts the parrot.<br>
(On Anytone DTMF ABCD -> P1 = A  P2 =B  up button =C down button =D)

### SVXLink Hotspot in action ###
https://github.com/Guru-RF/SVXSpot/assets/1251767/50dd4366-8439-4067-83b5-5866d0adca77
