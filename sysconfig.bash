#!/bin/bash

cd

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install vlc
sudo apt-get install cmake
sudo apt install python3-pip
pip3 install pyserial
pip3 install python-csv
sudo apt install -y gpac

git clone https://github.com/UMDBPP/userland.git

cd
cd userland

git checkout devel

./buildme

cd
cd LIVE

chmod +x servicesetup.bash

cd

sed -e '/bash/d' /etc/rc.local
sed -e '/python/d' /etc/rc.local
sed -e '$i \sudo bash /home/pi/LIVE/servicesetup.bash &\n' rc.local
