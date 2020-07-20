#!/bin/bash

# To install MP4Box, run 'sudo apt install -y gpac' in the terminal window.

echo "Enter the number of segmented video clips recorded:"

# The number inputted into the terminal will be stored in the variable 'numvid'

read numvid

if [[ "$numvid" -lt "10" ]]
then
    MP4Box -add video0001.h264 
    for i in {2..$numvid}
        do
        -cat video000$i.h264 
    done
    finalvideo.mp4 
fi

if [[ "$numvid" -ge "10" ]]
then
    if [[ "$numvid" -ge "100" ]]
    then 
        MP4Box -add video0001.h264 
        for i in {2..9}
            do
            -cat video000$i.h264 
        done
        for i in {10..99}
            do
            -cat video00$i.h264 
        done
        for i in {100..$numvid}
            do
            -cat video0$i.h264 
        done
        finalvideo.mp4 
    fi

else 
    MP4Box -add video0001.h264 
    for i in {2..$numvid}
        do
        -cat video000$i.h264
    done
    for i in {10..$numvid}
        do 
        -cat video00$i.h264
    done
    finalvideo.mp4
fi


echo "Video processing is complete!"
echo "Processed video file stored in 'finalvideo.mp4'"

