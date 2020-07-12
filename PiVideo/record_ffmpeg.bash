#!/bin/bash

ffmpeg -f v412 -input_format mjpeg -i /dev/video0 -c copy output.mkv
