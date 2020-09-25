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
        echo "Enter the name of the folder:"
        read folder1
    
    else
    echo "Enter the name of folder $i:"
    read foldername
    folder[$i]=$foldername
    
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
    
    rm videoprocessing.txt
    rm finalvideoprocess.txt
    rm finalvideo.mp4
    rm finalvideo$i.mp4
    
    numfilesinfolder=$(ls | wc -l)
    numvid=numfilesinfolder
   
   
    placeholdervar3=$i


    if [[ "$numvid" -lt "10" ]]
    then
        echo -n "MP4Box -add video0001.h264 " >> videoprocessing.txt
        for (( j = 2; j <= $numvid; j++ ))
            do
            echo -n "-cat video000" >> videoprocessing.txt
            echo -n "$j" >> videoprocessing.txt
            echo -n ".h264 " >> videoprocessing.txt
        done
        echo -n "finalvideo" >> videoprocessing.txt 
        echo -n "$placeholdervar3" >> videoprocessing.txt
        echo -n ".mp4" >> videoprocessing.txt
    fi


    if [[ "$numvid" -ge "100" ]]
    then 
        echo -n "MP4Box -add video0001.h264 " >> videoprocessing.txt
        for (( k = 2; k <= 9; k++ ))
            do
            echo -n "-cat video000" >> videoprocessing.txt
            echo -n "$k" >> videoprocessing.txt
            echo -n  ".h264 " >> videoprocessing.txt
        done
        for (( f = 10; f <= 99; f++ ))
            do
            echo -n "-cat video00" >> videoprocessing.txt
            echo -n "$f" >> videoprocessing.txt
            echo -n ".h264 " >> videoprocessing.txt
        done
        for (( w = 100; w <= $numvid; w++ ))
            do
            echo -n "-cat video0" >> videoprocessing.txt
            echo -n "$w" >> videoprocessing.txt
            echo -n ".h264 " >> videoprocessing.txt
        done
        echo -n "finalvideo" >> videoprocessing.txt 
        echo -n "$placeholdervar3" >> videoprocessing.txt
        echo -n ".mp4" >> videoprocessing.txt
    fi


    if [[ "$numvid" -ge "10" ]] && [[ "$numvid" -lt "100" ]]
    then
    
        echo -n "MP4Box -add video0001.h264 " >> videoprocessing.txt
    
        for (( q = 2; q < 10; q++ ))
            do
            echo -n "-cat video000" >> videoprocessing.txt
            echo -n "$q" >> videoprocessing.txt
            echo -n ".h264 " >> videoprocessing.txt
        done
        for (( z = 10; z <= $numvid; z++ ))
            do 
            echo -n "-cat video00" >> videoprocessing.txt
            echo -n "$z" >> videoprocessing.txt
            echo -n ".h264 " >> videoprocessing.txt
        done

        echo -n "finalvideo" >> videoprocessing.txt 
        echo -n "$placeholdervar3" >> videoprocessing.txt
        echo -n ".mp4" >> videoprocessing.txt

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
    
    mv /home/pi/LIVE/segmented_videos/$placeholdervar2/finalvideo$i.mp4 /home/pi/LIVE/processed_videos/$flight
    
done

cd 
cd /home/pi/LIVE/processed_videos/$flight

rm finalvideoprocess.txt

echo -n "MP4Box -add " >> finalvideoprocess.txt
echo -n "finalvideo1.mp4 " >> finalvideoprocess.txt

for (( i = 1; i <= $numdir; i++ ))
    do
    cd 
    cd /home/pi/LIVE/processed_videos/$flight
    if [ $i -eq 1 ]
    then
        continue
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
cd /home/pi/LIVE/processed_videos/$flight

rm finalvideoprocess.txt

for (( i = 1; i <= $numdir; i++ ))
    do 
    
    rm finalvideo$i.mp4

done
    

echo "Video processing is complete!"
