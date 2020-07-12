#!/bin/bash

# change to path where you would like segmented videos to be stored
cd ~/LIVE/segmented_videos

# -t 100000 = video time limit is 100 seconds
# -sg 5000 = video segments every 5 seconds

raspivid -t 100000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -sg 5000 -o video%04d.h264 -send | cvlc -vvv stream:///dev/stdin --sout '#rtp{sdp=rtsp://:2431/}' :demux=h264