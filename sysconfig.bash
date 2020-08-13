#!/bin/bash



cd

sudo sed -i -e '/bash/d' /etc/rc.local
sudo sed -i -e '/python/d' /etc/rc.local
sudo sed -i -e '$i \sudo bash /home/pi/LIVE/servicesetup.bash &\n' /etc/rc.local
