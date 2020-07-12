#!/bin/bash

#This script records 15 seconds of video in 1280x960 format and then saves the raw footage file in mp4 format.

raspivid -t 15000 -w 1280 -h 960 -fps 25 -b 1200000 -p 0,0,1280,960 -o video1.h264

MP4Box -add video1.h264 video1.mp4 

rm video1.h264
