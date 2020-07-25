#!/bin/bash

# This script will record video from the Raspberry Pi camera module, and stream it through the VLC media player to a port connected to the Raspberry Pi IP address.
# In order to function properly, this script requires the modified raspivid application to be downloaded from the UMDBPP/userland repository.
# The video feed will be captured for 2.5 hours, and the feed will be saved in 20 second increments as an h264 file.

# Change to path where you would like segmented videos to be stored.
cd ~/LIVE/segmented_videos

# -t 100000 = video time limit is 100 seconds
# -sg 5000 = video segments every 5 seconds

raspivid -t 9000000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -n -sg 20000 -o video%04d.h264 -send | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:2431/}' :demux=h264

# Stream can be accessed on another computer by opening the VLC media player, navigating to File, clicking on Open Network, and inputting rtsp://<raspberrypi_IPaddress>:2431/
