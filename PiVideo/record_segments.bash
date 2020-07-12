#!/bin/bash

#This script records 15 seconds of video in 1280x960 format, at 25 frames per second, in 3 second segments.

raspivid -t 15000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -sg 3000 -o video%04d.h264

