# LIVE software

# To run full software suite at boot:
add 'sudo bash /home/pi/LIVE/servicesetup.bash &' to /etc/rc.local

# Description
There are 4 components to the flight software: video streaming, video recording, PID controller, and data logging.

There are 2 compoenents to the post-flight data analysis: video merging and data log merging.

# Dependencies
For the Raspberry Pi 3B+, we are using a Raspbian Stretch image from 2019-04-08 found here: https://howchoo.com/g/nzc0yjzjy2u/raspbian-stretch-download

- For data logging, we are using Python 3.5.3. Our necessary python3 modules are pyserial and python-csv (use pip3 to install).

- For video streaming, we are using ___<insert packages/drivers needed here Ruben>___.

- For video recording, we are using ___<insert packages/drivers needed here Ruben>___.

For our Teensy 3.5, we are using Arduino 1.8.12 with a Teensyduino driver.

- For the PID controller, install Wire, Adafruit_Sensor, Adafruit_BNO055, utility/imumaths, Servo, and PID (use Arduino Library Manager)
