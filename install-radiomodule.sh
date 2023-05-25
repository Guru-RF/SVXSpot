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

say "Upgrading PI"
run "apt -y update"
run "apt -y upgrade"

say "Installing Prerequisites"
run "apt -y install python3-pip git python3-pyaudio python3-scipy"

say "Installing SA818 Control Software"
run "pip3 install sa818"

say "Modify Locale"
run "echo 'LANG=en_US.UTF-8' > /etc/default/locale"
run "echo 'LC_CTYPE=en_US.UTF-8' >> /etc/default/locale"
run "echo 'LC_MESSAGES=en_US.UTF-8' >> /etc/default/locale"
run "echo 'LC_ALL=en_US.UTF-8' >> /etc/default/locale"
run "echo 'en_US.UTF-8 UTF-8' > /etc/locale.gen"

run "locale-gen"

say "Installing WM8960 audio intgerface"
# test audio files https://www2.cs.uic.edu/~i101/SoundFiles/
run "git clone https://github.com/waveshare/WM8960-Audio-HAT"
cd WM8960-Audio-HAT/
run "./install.sh"
cd ..

# Disable hdmi-audio and enable serial uart
say "Disabling HDMI audio"
run "perl -i -pe 's/dtoverlay=vc4-kms-v3d/dtoverlay=vc4-kms-v3d,noaudio/g' /boot/config.txt"
say "Disabling Bluetooth"
run "grep -q 'dtoverlay=disable-bt' /boot/config.txt || echo 'dtoverlay=disable-bt' >> /boot/config.txt"
run "sudo systemctl disable hciuart.service"
run "sudo systemctl disable bluealsa.service"
run "sudo systemctl disable bluetooth.service"
say "Disabling Serial Console"
run "perl -i -pe 's/console=serial0.115200//g'  /boot/cmdline.txt"
say "Enabling UART"
run "grep -q 'enable_uart=1' /boot/config.txt || echo 'enable_uart=1' >> /boot/config.txt"
say "Disabling serial getty"
run 'systemctl disable serial-getty@ttyS0.service'
say "Disabling wm8960-soundcard service"
run 'systemctl disable wm8960-soundcard'

say "Installing hotspot eeprom configurator"
run "cp hotspot /usr/sbin"
run "chmod a+x /usr/sbin/hotspot"

say "Installing hotspot_volume"
run "cp hotspot_volume /usr/sbin/hotspot_volume"
run "chmod a+x /usr/sbin/hotspot_volume"

say "Please reboot system."
