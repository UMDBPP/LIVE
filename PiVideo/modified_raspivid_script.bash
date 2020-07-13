#!/bin/bash

# This script will record video from the Raspberry Pi camera module, and stream it through the VLC media player to a port connected to the Raspberry Pi IP address.
# The video feed will be captured for 2.5 hours, and the feed will be saved in 20 second increments as an h264 file.

raspivid -t 9000000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -sg 20000 -o video%04d.h264 -send | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:2431/}' :demux=h264
