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

if [ "$EUID" -ne 0 ]
  then say "Please run as root"
  exit
fi

MYPATH=${PWD}

cd /tmp

say "Run apt autoremove"
run "apt -y autoremove"

say "Stop svxlink & apache"
run "systemctl stop svxlink"
run "systemctl stop apache2"

say "Installing SVXLink Prerequisites"
run "apt install libssl-dev ladspa-sdk moreutils build-essential g++ make cmake libsigc++-2.0-dev php libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet sox bc avahi-daemon avahi-utils -y"

say "Installing/Compiling SVXLink"
run "git clone https://github.com/sm0svx/svxlink.git"
run "mkdir svxlink/src/build"
run "cd svxlink/src/build/"
run "cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  .."
run "make -j1"
run "make doc"
run "make install"

say "Updating Logic.tcl"
run "wget https://raw.githubusercontent.com/Guru-RF/SVXSpot/master/Logic.tcl"
run "cp Logic.tcl /usr/share/svxlink/events.d/local/Logic.tcl"

say "Updating svxlink.service"
run "wget https://raw.githubusercontent.com/Guru-RF/SVXSpot/master/svxlink-v2.service"
run "cp svxlink-v2.service /lib/systemd/system/svxlink.service"

say "Updating remotetrx.service"
run "wget https://raw.githubusercontent.com/Guru-RF/SVXSpot/master/remotetrx.service"
run "cp remotetrx.service /lib/systemd/system/remotetrx.service"

say "Cleanup"
run "cd /tmp && rm -fr svxlink"

say "Restart svxlink"
say "Stop svxlink & apache"
run "systemctl daemon-reload"
run "systemctl restart svxlink"
run "systemctl restart apache2"

cd ${MYPATH}
