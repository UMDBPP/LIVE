#!/bin/bash

# To install MP4Box, run 'sudo apt install -y gpac' in the terminal window.

echo "Enter the number of segmented video clips recorded:"

# The number inputted into the terminal will be stored in the variable 'numvid'
# The number entered should be the number of video clips that were recorded (the greatest string of numbers following 'video' in the filename, excluding any leading zeros)

read numvid

rm videoprocessing.txt


if [[ "$numvid" -lt "10" ]]
then
    echo -n "MP4Box -add video0001.h264 " >> videoprocessing.txt
    for (( i = 2; i <= $numvid; i++ ))
        do
        echo -n "-cat video000" >> videoprocessing.txt
        echo -n "$i" >> videoprocessing.txt
        echo -n ".h264 " >> videoprocessing.txt
    done
    echo -n "finalvideo.mp4" >> videoprocessing.txt
fi


if [[ "$numvid" -ge "100" ]]
then 
    echo -n "MP4Box -add video0001.h264 " >> videoprocessing.txt
    for (( i = 2; i <= 9; i++ ))
        do
        echo -n "-cat video000" >> videoprocessing.txt
        echo -n "$i" >> videoprocessing.txt
        echo -n  ".h264 " >> videoprocessing.txt
    done
    for (( i = 10; i <= 99; i++ ))
        do
        echo -n "-cat video00" >> videoprocessing.txt
        echo -n "$i" >> videoprocessing.txt
        echo -n ".h264 " >> videoprocessing.txt
    done
    for (( i = 100; i <= $numvid; i++ ))
        do
        echo -n "-cat video0" >> videoprocessing.txt
        echo -n "$i" >> videoprocessing.txt
        echo -n ".h264 " >> videoprocessing.txt
    done
    echo -n "finalvideo.mp4" >> videoprocessing.txt
fi


if [[ "$numvid" -ge "10" ]] && [[ "$numvid" -lt "100" ]]
then
    
    echo -n "MP4Box -add video0001.h264 " >> videoprocessing.txt
    
    for (( i = 2; i < 10; i++ ))
        do
        echo -n "-cat video000" >> videoprocessing.txt
        echo -n "$i" >> videoprocessing.txt
        echo -n ".h264 " >> videoprocessing.txt
    done
    for (( i = 10; i <= $numvid; i++ ))
        do 
        echo -n "-cat video00" >> videoprocessing.txt
        echo -n "$i" >> videoprocessing.txt
        echo -n ".h264 " >> videoprocessing.txt
    done

    echo -n "finalvideo.mp4" >> videoprocessing.txt 

fi

$(sed -n '1p' videoprocessing.txt)

echo "Video processing is complete!"
echo "Processed video file stored in 'finalvideo.mp4'"

