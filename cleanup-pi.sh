#!/bin/bash

cd /var/log

journalctl --rotate
journalctl --vacuum-time=1s
find . | grep "\.[1-9]$" | grep -v journal | xargs rm
find . | grep "\.log$" | xargs truncate -s0
truncate -s0 svxlink

# disables log files (not beeing used)
apt --autoremove purge rsyslog

apt -y autoremove
apt -y clean
apt -y autoclean
