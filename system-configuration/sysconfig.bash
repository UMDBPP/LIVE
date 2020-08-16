#!/bin/bash

cd

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install vlc
sudo apt-get install cmake
sudo apt install python3-pip
sudo pip3 install pyserial
sudo pip3 install python-csv
sudo apt install -y gpac

cd

git clone https://github.com/UMDBPP/userland.git

cd
cd userland

git checkout devel

./buildme

cd
cd LIVE
cd system-configuration

chmod +x servicesetup.bash

cd

sudo sed -i -e '/bash/d' /etc/rc.local
sudo sed -i -e '/python/d' /etc/rc.local
sudo sed -i -e '$i \sudo bash /home/pi/LIVE/servicesetup.bash &\n' /etc/rc.local
