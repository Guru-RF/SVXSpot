# SVXSpot an SVXLink Analog Hotspot 70CM (UHF) for the Raspberry Pi Zero ([RF.Guru SVXSpot](https://rf.guru/2023-k-041))

[RF.Guru Analog Hotspot 70CM (UHF)](https://rf.guru/2023-k-041) (Currently for sale)

[RF.Guru Analog Hotspot 2M (VHF)](https://rf.guru/) (In development)

Those boards can also be used for analog ham radio experiments on the 70cm and 2m ham radio bands.

# SVXLink Bookworm Image #

[Bookworm 32Bit Lite 2023-11-10](https://storage.googleapis.com/rf-guru/rpi-images/hotspot-2023-11-10.img.gz)

Use PI-Imager to burn the image (Operating System -> Use custom) add user and WiFi credentials and enable SSH access (click on the gear) !!!

Upon accessing the hotspot through SSH, adjust your credentials by replacing ON0RFG with your CALL and PASSWORD with your password.

```console
sudo perl -i -pe 's/--CALL--/ON0RFG/g' /etc/svxlink/svxlink.conf
sudo perl -i -pe 's/--PWD--/PASSWORD/g' /etc/svxlink/svxlink.conf
sudo systemctl restart svxlink
```

Then restart svxlink with systemctl restart svxlink

# SVXLink and Radiomodule install scripts

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
