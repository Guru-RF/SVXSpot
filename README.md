# SVXSpot an SVXLink Analog Hotspot 70CM (UHF) for the Raspberry Pi Zero ([RF.Guru SVXSpot](https://rf.guru/2023-k-041))

[RF.Guru Analog Hotspot 70CM (UHF)](https://rf.guru/2023-k-041) (Currently for sale)

[RF.Guru Analog Hotspot 2M (VHF)](https://rf.guru/) (In development)

Those boards can also be used for analog ham radio experiments on the 70cm and 2m ham radio bands.

# SVXLink Bookworm Image #

[Bookworm 32Bit Lite 2023-11-11](https://storage.googleapis.com/rf-guru/rpi-images/hotspot-2023-11-11.img.gz)
New image with hotspot-config will be available later today !

Use PI-Imager to burn the image (Operating System -> Use custom) add user and WiFi credentials and enable SSH access (click on the gear) !!!

[Youtube demonstration of how to use PI-Imager](https://www.youtube.com/watch?v=UeiBUUef2c0)

(Seems that the pi freezes after resizing the FS ... for now at first boot wait 5 minutes, remove power and boot up again.)

You need SSH to do the last bit of configuration, for linux/mac ssh is installed by default open a terminal and you can type ssh username@ip

For windows however you need an extra application, for instance Putty
[Youtube how to install putty on Windows 11](https://www.youtube.com/watch?v=ljL4Wvv8XwI)

Make sure you download for right archetecture, for most it will be x86 64 bit !!

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
