#!/bin/bash

systemctl stop svxlink
curl -L -o /tmp/ImperialMarch60.wav https://github.com/Guru-RF/SVXSpot/raw/master/ImperialMarch60.wav
/usr/sbin/hotspot_volume > /dev/null 2>&1
/usr/sbin/hotspot
raspi-gpio set 16 dl
aplay /tmp/ImperialMarch60.wav
raspi-gpio set 16 dh
echo "Send audio with your portable ... recording for 20seconds"
arecord -V stereo -r 44100 -f S16_LE -c 2 /tmp/test.wav -d 20
echo "Playing recording"
raspi-gpio set 16 dl
aplay /tmp/test.wav
raspi-gpio set 16 dh
