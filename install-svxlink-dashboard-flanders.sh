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

say "Install php.ini"
run "cp php.ini /etc/php/8.2/apache2/php.ini"

say "Enable Apache"
run "systemctl enable apache2"
run "systemctl enable apache-htcacheclean"

say "Remove default html dir"
run "rm -fr /var/www/html"

say "Clone dashboard from repo"
run "cd /var/www; git clone https://github.com/Guru-RF/SVXLink-Dash-V2-FLANDERS.git html; chown -R svxlink:svxlink html"

say "Start Apache"
run "systemctl start apache2"

say "Add Apache to sudoers"
run "usermod --shell /bin/bash www-data"
run "usermod -aG sudo www-data"
run "echo 'www-data ALL=(ALL) NOPASSWD: ALL' > /etc/sudoers.d/020_www-data-nopasswd"


HOSTNAME=$(hostname)
say "You should be able to access the dashboard via: http://${HOSTNAME}.local"







