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

say "Install /usr/sbin/mylocalip"
run "cp mylocalip /usr/sbin/mylocalip"

say "Install /usr/sbin/svxlink-message"
run "cp svxlink-message /usr/sbin/svxlink-message"

say "Install /usr/sbin/svxlink-internet-checker"
run "cp svxlink-internet-checker /usr/sbin/svxlink-internet-checker"

say "Install /etc/cron.d/checkinternet"
run "cp checkinternet /etc/cron.d/checkinternet"

say "Install /usr/share/svxlink/events.d/local/Logic.tcl"
run "cp Logic.tcl /usr/share/svxlink/events.d/local/Logic.tcl"

say "Install shellinabox"
say "apt -y install shellinabox"

say "Enable/Start shellinabox"
run "systemctl enable shellinabox"
run "systemctl start shellinabox"

say "White on Black shellinabos by default"
run "cd /etc/shellinabox/options-enabled && mv 00+Black\ on\ White.css 00_Black\ on\ White.css"

say "Install https://www.raspberryconnect.com/projects/65-raspberrypi-hotspot-accesspoints/203-automated-switching-accesspoint-wifi-network manually"

say "Remove logs via rm -f /var/log/svxlink"

say "Clean systemd logs via sudo systemd-tmpfiles --clean"

say "Confuscate svxlink.conf and node_info.json !"

say "Remove ssh keys via rm -f /etc/ssh/ssh_host*"

say "Remove history with history -c && history -w"

say "Remove WiFi's with nmtui"









