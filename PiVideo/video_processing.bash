#!/bin/bash

# To install MP4Box, run 'sudo apt install -y gpac' in the terminal window.

echo "Enter the number of segmented video clips recorded:"

# The number inputted into the terminal will be stored in the variable 'numvid'

read numvid

-rm videoprocessing.txt

if [[ "$numvid" -lt "10" ]]
then
    echo "MP4Box -add video0001.h264 " >> videoprocessing.txt
    for i in {2..$numvid}
        do
        echo -n "-cat video000$i.h264 " >> videoprocessing.txt
    done
    echo -n "finalvideo.mp4" >> videoprocessing.txt
fi

if [[ "$numvid" -ge "10" ]]
then
    if [[ "$numvid" -ge "100" ]]
    then 
        echo "MP4Box -add video0001.h264 " >> videoprocessing.txt
        for i in {2..9}
            do
            echo -n "-cat video000$i.h264 " >> videoprocessing.txt
        done
        for i in {10..99}
            do
            echo -n "-cat video00$i.h264 " >> videoprocessing.txt
        done
        for i in {100..$numvid}
            do
            echo -n "-cat video0$i.h264 " >> videoprocessing.txt
        done
        echo -n "finalvideo.mp4" >> videoprocessing.txt
    fi

elif [[ "$numvid" -lt "100" ]]
    echo "MP4Box -add video0001.h264 " >> videoprocessing.txt
    for i in {2..$numvid}
        do
        echo -n "-cat video000$i.h264 " >> videoprocessing.txt
    done
    for i in {10..$numvid}
        do 
        echo -n "-cat video00$i.h264 " >> videoprocessing.txt
    done
    echo -n "finalvideo.mp4" >> videoprocessing.txt
fi

$(sed -n '1p' videoprocessing.txt)

echo "Video processing is complete!"
echo "Processed video file stored in 'finalvideo.mp4'"

