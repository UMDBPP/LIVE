#!/bin/bash

# This script will record video from the Raspberry Pi camera module, and stream it through the VLC media player to a port connected to the Raspberry Pi IP address.
# The video feed will be captured for 2.5 hours, and the feed will be saved in 20 second increments as an h264 file.

# Change to path where you would like segmented videos to be stored.

cd

# Create a folder with the name of the current date and time.

date_info=$(date +%b-%d-%Y_%H-%M-%S)

cd /home/pi/LIVE
mkdir segmented_videos

cd 
cd /home/pi/LIVE/segmented_videos
mkdir $date_info

cd 
cd /home/pi/LIVE/segmented_videos/$date_info

# -t 100000 = video time limit is 100 seconds
# -sg 5000 = video segments every 5 seconds

raspivid -t 18000000 -w 1920 -h 1080 -fps 25 -b 1200000 -p 0,0,1920,1280 -vf -hf -n -sg 20000 -o video%04d.h264 -send | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:2431/}' :demux=h264

# Stream can be accessed on another computer by opening the VLC media player, navigating to File, clicking on Open Network, and inputting rtsp://<raspberrypi_IPaddress>:2431/

