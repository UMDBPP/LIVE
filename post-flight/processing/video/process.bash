#!/bin/bash

# To install MP4Box, run 'sudo apt install -y gpac' in the terminal window.

echo "Enter the name of the flight for which you wish to process video:"

read flight

echo "Enter the number of folders that contain video clips that you wish to merge together:"

read numdir

for (( i = 1; i <= $numdir; i++ ))
    do
    if [ $numdir -eq 1 ]
    then
        echo "Enter the name of the first folder:"
        read folder1
    
    else
    echo "Enter the name of folder $i:"
    read foldername
    folder[$i]=foldername
    
    fi
    
done

for (( i = 1; i <= $numdir; i++ ))
    do
    cd 
    cd /home/pi/LIVE
    cd segmented_videos
    
    placeholdervar1=folder[$i]
    placeholdervar2=${!placeholdervar1}
    
    cd $placeholdervar2
    
    numfilesinfolder=$(ls | wc -l)
    numvid=numfilesinfolder
    

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

done

cd 
cd /home/pi/LIVE
mkdir processed_videos
cd 
cd /home/pi/LIVE
cd processed_videos
mkdir $flight
cd
cd /home/pi/LIVE/processed_videos
cd $flight

for (( i = 1; i <= $numdir; i++ ))
    do
    cd
    cd /home/pi/LIVE
    cd segmented_videos
    
    placeholdervar1=folder[$i]
    placeholdervar2=${!placeholdervar1}
    
    cd $placeholdervar2
    
    mv finalvideo.mp4 finalvideo$i.mp4
    mv /home/pi/LIVE/segmented_videos/$placeholdervar2/finalvideo$i /home/pi/LIVE/processed_videos/$flight
    
done

rm finalvideoprocess.txt

echo -n "MP4Box -add " >> finalvideoprocess.txt

for (( i = 1; i <= $numdir; i++ ))
    do
    cd 
    cd /home/pi/LIVE/processed_videos/$flight
    if [ $i -eq 1 ]
    then
        echo -n "finalvideo1.mp4 " >> finalvideoprocess.txt
    else
        echo -n "-cat finalvideo" >> finalvideoprocess.txt
        echo -n "$i" >> finalvideoprocess.txt
        echo -n ".mp4 " >> finalvideoprocess.txt
    fi
    
done

echo -n "$flight" >> finalvideoprocess.txt
echo -n ".mp4" >> finalvideoprocess.txt

cd
cd /home/pi/LIVE/processed_videos/$flight

$(sed -n '1p' finalvideoprocess.txt)

cd

echo "Video processing is complete!"
