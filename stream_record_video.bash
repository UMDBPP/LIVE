#!/bin/bash

# change to path where you would like segmented videos to be stored
cd ~/LIVE/segmented_videos

raspivid -t 15000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -sg 3000 -o video%04d.h264 -send | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:2431/}' :demux=h264