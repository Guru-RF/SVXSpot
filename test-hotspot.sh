#!/bin/bash

run() {
  exec=$1
  printf "\x1b[38;5;104m --> ${exec}\x1b[39m\n"
  eval ${exec}
}

say () {
  say=$1
  printf "\x1b[38;5;220m${say}\x1b[38;5;255m\n"
}

say "Stopping svxlink"
run "systemctl stop svxlink"
say "Downloading Imperial March 60 seconds test audio"
run "curl -L -o /tmp/ImperialMarch60.wav https://github.com/Guru-RF/SVXSpot/raw/master/ImperialMarch60.wav > /dev/null 2>&1"
say "Setting hotspot volume"
run "/usr/sbin/hotspot_volume > /dev/null 2>&1"
say "Configuring RF module"
run "/usr/sbin/hotspot"
say "PTT on"
run "raspi-gpio set 16 dl"
say "Play Imperail March for 60 seconds"
run "aplay /tmp/ImperialMarch60.wav"
say "PTT off"
run "raspi-gpio set 16 dh"
say "Send audio with your portable ... recording for 20seconds"
run "arecord -V stereo -r 44100 -f S16_LE -c 2 /tmp/test.wav -d 20"
say "PTT on"
run "raspi-gpio set 16 dl"
say "Playing recording"
run "aplay /tmp/test.wav"
say "PTT off"
run "raspi-gpio set 16 dh"
say "Turning svxlink back on"
run "systemctl start svxlink"
