#!/bin/bash

# After script is executed, run 'sudo systemctl status video.service' and then 'sudo systemctl status video.service' to ensure that the services are configured correctly.

sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc

cd 
cd LIVE
chmod +x data_logging.py

cd PiVideo
chmod +x stream1080.bash

cd
cd LIVE

sudo cp video.service /etc/systemd/system
sudo systemctl daemon-reload

sudo cp data.service /etc/systemd/system # does not work
sudo systemctl daemon-reload

sudo systemctl enable video.service
sudo systemctl start video.service

sudo systemctl enable data.service
sudo systemctl start data.service

