#!/bin/bash



cd

sed -i -e '/bash/d' /etc/rc.local
sed -i -e '/python/d' /etc/rc.local
sed -i -e '$i \sudo bash /home/pi/LIVE/servicesetup.bash &\n' /etc/rc.local
