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

say "remove old kernels"
sudo bash ./remove-old-kernels.sh
say "cleanup logs"
sudo bash ./cleanup-pi.sh
say "install default configs"
cat svxlink.conf.hsdefault > /etc/svxlink/svxlink.conf
cat node_info.json.hsdefault > /etc/svxlink/node_info.json
say "remove ssh keys"
sudo bash ./regenerate-ssh-keys.sh

say "remove svxspot repo and"
say "run:"
say "history -c && history -w"
say "as root as root and halt the system"