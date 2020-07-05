# LIVE software

# Description
There are 3 main components for our flight software: video recording, PID controller, and data logging.

Our post-flight data analysis will include a video merge script and data logging merge script.

# Dependencies
For Raspberry Pi, all software will employ Python 3.5.3. The necessary python3 packages are pyserial and python-csv with pip3 install (both needed for data logging).

***Ruben - insert depedncies about video recording/streaming here once complete***

For Arduino, install these libraries using Library Manager in order to run the PID controller: Wire, Adafruit_Sensor, Adafruit_BNO055, utility/imumaths, Servo, and PID.
