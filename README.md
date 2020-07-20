# LIVE software- Master Branch
 *Just a heads up this is only for final software go check beta or alfa for non-finalized software*

# Description
There are 4 components to the flight software: video streaming, video recording, PID controller, and data logging.

There are 2 components to the post-flight data analysis: video merging and data log merging.

# Dependencies
For the Raspberry Pi 3B+, we are using a Raspbian Stretch image from 2019-04-08 found here: https://howchoo.com/g/nzc0yjzjy2u/raspbian-stretch-download

- For data logging, we are using Python 3.5.3. Our necessary python3 modules are pyserial and python-csv (use pip3 to install).

- For video streaming, we are utilizing the native raspivid application on the Raspberry Pi and the VLC media player, which can be downloaded using `sudo apt install vlc` in the terminal.

- For video recording, we are using a modified version of the native raspivid application on the Raspberry Pi. To make the modifications to the raspivid source code, we downloaded the VIM editor using `sudo apt install vim` in the terminal. We also downloaded github, using `sudo apt install git` so that we could clone the repository containing the raspivid source code.

For our Teensy 3.5, we are using Arduino 1.8.12 with a Teensyduino driver.

- For the PID controller, install Wire, Adafruit_Sensor, Adafruit_BNO055, utility/imumaths, Servo, and PID (use Arduino Library Manager)
