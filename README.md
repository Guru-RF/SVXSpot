# SVXSpot an SVXLink Analog Hotspot 70CM (UHF) for the Raspberry Pi Zero ([RF.Guru SVXSpot](https://rf.guru/2023-k-041))

This board can also be used for analog ham radio experiments on the 70cm ham radio bands.

### SVXLink and Radiomodule install scripts: ###

Prepare your sd-card with Raspberry PI OS Lite ! ([Youtube](https://www.youtube.com/watch?v=vxmO_a5WNI8))

# WARNING! We are in the mitst in upgrading this to bookworm. for now use the ([bullseye](https://github.com/Guru-RF/SVXSpot/tree/v1.11.0) release !

Login to your system with ssh add run following commands:

### Install GIT  ###
```console
sudo apt -y install git
```

### Clone repostory ###
```console
git clone https://github.com/Guru-RF/SVXSpot.git
```

### Audio and Radio module installation script ###
```console
cd SVXSpot
sudo bash install-radiomodule.sh
```

### SVXLink installation script ###
```console
cd SVXSpot
sudo bash install-svxlink.sh
```

### Simple Test ###
Sending D1# dtmf on the configured frequency starts the parrot.

### SVXLink Hotspot in action ###
https://github.com/Guru-RF/SVXSpot/assets/1251767/50dd4366-8439-4067-83b5-5866d0adca77
