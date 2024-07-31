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

MYPATH=${PWD}

say "Installing SVXLink Prerequisites"
run "apt install libssl-dev ladspa-sdk moreutils build-essential g++ make cmake libsigc++-2.0-dev php libgsm1-dev libudev-dev libpopt-dev tcl-dev libgpiod-dev gpiod libgcrypt20-dev libspeex-dev libasound2-dev alsa-utils libjsoncpp-dev libopus-dev rtl-sdr libcurl4-openssl-dev libogg-dev librtlsdr-dev groff doxygen graphviz python3-serial toilet sox bc avahi-daemon avahi-utils -y"

say "Adding svxlink user and groups"
run "groupadd svxlink"
run "useradd -g svxlink -d /etc/svxlink svxlink"
run "usermod -aG audio,nogroup,svxlink,plugdev svxlink"
run "usermod -aG gpio svxlink"

say "Installing/Compiling SVXLink"
run "git clone --branch maint https://github.com/sm0svx/svxlink.git"
run "mkdir svxlink/src/build"
run "cd svxlink/src/build/"
run "cmake -DUSE_QT=OFF -DCMAKE_INSTALL_PREFIX=/usr -DSYSCONF_INSTALL_DIR=/etc -DLOCAL_STATE_DIR=/var -DWITH_SYSTEMD=ON  .."
run "make -j1"
run "make doc"
run "make install"
cd ${MYPATH}

say "Creating events.d symlink"	
run "cd /usr/share/svxlink/events.d"
run "ln -s . local"
cd ${MYPATH}

say "Updating LD"
run "ldconfig"

say "Installing svxlink sounds"
run "cd /usr/share/svxlink/sounds"
run 'git clone "https://github.com/sm0svx/svxlink-sounds-en_US-heather"'
run "${MYPATH}/svxlink/src/svxlink/scripts/filter_sounds.sh -r 16000 svxlink-sounds-en_US-heather en_US"
run "rm -fr svxlink-sounds-en_US-heather"
run "rm -f svxlink-sounds-en_US.tar.bz2"

cd ${MYPATH}
say "Install svxlink_rotate"
run "cp svxlink_rotate /usr/sbin"
run "chmod a+x /usr/sbin/svxlink_rotate"
run "ln -s /usr/sbin/svxlink_rotate /etc/cron.daily/svxlink_rotate"

say "Install svxlink_checkalsa"
run "cp svxlink_checkalsa /usr/sbin"
run "chmod a+x /usr/sbin/svxlink_checkalsa"

say "Updating svxlink.service"
run "cp svxlink.service /lib/systemd/system/svxlink.service"
say "Updating remotetrx.service"
run "cp remotetrx.service /lib/systemd/system/remotetrx.service"

say "Install hostspot_logger"
run "cp hotspot_logger /usr/sbin/hotspot_logger"
run "chmod +x /usr/sbin/hotspot_logger"

say "Install hotspot_dtmf"
run "cp hotspot_dtmf /usr/sbin/hotspot_dtmf"
run "chmod +x /usr/sbin/hotspot_dtmf"

say "Sysctl UDP tuning parameters"
run "cp 97-rfguru.conf /etc/sysctl.d/97-rfguru.conf"

say "Install Gum"
run "cp gum /usr/sbin/gum"
run "chmod a+rx /usr/sbin/gum"

say "Install svxlink-update-main"
run "cp svxlink-update-main.sh /usr/sbin/svxlink-update-main"
run "chmod +x /usr/sbin/svxlink-update-main"

say "Install svxlink-update-release"
run "cp svxlink-update-release.sh /usr/sbin/svxlink-update-release"
run "chmod +x /usr/sbin/svxlink-update-release"

say "Install hostspot-config"
run "cp hotspot-config /usr/sbin/hotspot-config"
run "chmod +x /usr/sbin/hotspot-config"

say "Installing default configurations"
run "cat svxlink.conf > /etc/svxlink/svxlink.conf"
run "cat svxlink.conf > /etc/svxlink/svxlink.conf.orig"

say "Installing systemd services"
run "systemctl enable svxlink"

say "Cleanup system"
run "sudo apt clean"
run "sudo apt autoclean"

say "Starting hotspot configation !"
run "/usr/sbin/hotspot-config"





