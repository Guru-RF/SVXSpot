#!/bin/bash

systemctl stop svxlink
/usr/sbin/hotspot_volume
/usr/sbin/hotspot
raspi-gpio set 16 dl
aplay ImperialMarch60.wav
raspi-gpio set 16 dl
echo "Send audio with your portable ... recording for 20seconds"
arecord -V stereo -r 44100 -f S16_LE -c 2 /tmp/test.wav -d 20
echo "Playing recording"
raspi-gpio set 16 dl
aplay /tmp/test.wav
raspi-gpio set 16 dh
