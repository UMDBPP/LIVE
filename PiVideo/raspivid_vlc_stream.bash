#!/bin/bash

# This script will record video from the Raspberry Pi camera module, and stream it through the VLC media player to a port connected to the Raspberry Pi IP address.

raspivid -t 0 -w 1280 -h 960 -fps 20 -b 2000000 -o - | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:2431/}' :demux=h264

