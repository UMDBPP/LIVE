#!/bin/bash

sudo apt-get update
sudo apt-get upgrade

sudo apt-get install vlc
sudo apt-get install cmake
sudo apt install python3-pip
pip3 install pyserial
pip3 install python-csv

git clone https://github.com/UMDBPP/userland.git

cd
cd userland

git checkout devel

./buildme


