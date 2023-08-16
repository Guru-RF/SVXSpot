# SVXSpot an SVXLink Hotspot (2M/70CM) for the Raspberry Pi Zero ([RF.Guru SVXSpot](https://rf.guru/2023-k-041))

EchoLink configuration example

### edit /etc/svxlink/svxlink.conf ###

modify the SimplexLogic portion (add ModuleEchoLink to the MODULE list):

```console
[SimplexLogic]
TYPE=Simplex
RX=Rx1
TX=Tx1
MODULES=ModuleParrot,ModuleEchoLink

modify the Macros portion (add another dtmf code to spawn echolink and connect to remote repeater nr, 
in this case the famous ON0WV in Bruges):

[Macros]
1=Parrot:0123456789#
2=EchoLink:357361#
```


### edit /etc/svxlink/svxlink.d/ModuleEchoLink.conf ###

Modify CALLSIGN with your echolink callsign and PASSWORD (your echolink password), those are mandatory.

### restart svxlink ###
```console
systemctl restart svxlink
```

### test ###
Sending D2# dtmf on the configured frequency starts the connection to echlink and the configured node (in this case ON0WV)

### SVXLink Hotspot in action conecting to ON0WV via echolink ###
https://github.com/Guru-RF/SVXSpot/assets/1251767/50dd4366-8439-4067-83b5-5866d0adca77
