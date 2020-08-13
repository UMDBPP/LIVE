#!/bin/bash

# Will make modifications to rc.local in order to configure the data and video services to run at boot

cd

chmod +x servicesetup.bash

sudo sed -i -e '/bash/d' /etc/rc.local
sudo sed -i -e '/python/d' /etc/rc.local
sudo sed -i -e '$i \sudo bash /home/pi/LIVE/servicesetup.bash &\n' /etc/rc.local
