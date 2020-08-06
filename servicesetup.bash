#!/bin/bash

sudo sed -i 's/geteuid/getppid/' /usr/bin/vlc

sudo cp video.service /etc/systemd/system

sudo systemctl enable video.service