#!/usr/bin/python3

import subprocess
f = subprocess.Popen(['tail','-n 0','-F','/var/log/svxlink'],\
        stdout=subprocess.PIPE,stderr=subprocess.PIPE)
while True:
    line = f.stdout.readline()
    if 'Turning the transmitter OFF' in str(line):
      print("Reset FM Chip")
      subprocess.run(["sa818","--port", "/dev/ttyAMA0", "filters", "--emphasis", "disable", "--highpass", "disable", "--lowpass", "disable"])
