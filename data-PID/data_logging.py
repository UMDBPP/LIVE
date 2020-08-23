#!/usr/bin/env python3

import serial
import csv
import os
import time
from datetime import datetime


ser=serial.Serial('/dev/ttyACM0',115200,timeout=1)   # find correct device with "ls /dev/tty*"
ser.flush()  # flushes any I/O buffer to avoid sending incomplete data at start of serial communication

now = datetime.now()
current_dt = now.strftime("%b-%d-%Y_%H-%M-%S")
if os.path.isdir('/home/pi/LIVE/segmented_data') == False:
  os.mkdir('/home/pi/LIVE/segmented_data')

while True:
 if os.path.isdir('/home/pi/LIVE/segmented_data/'+str(current_dt))==False:
  os.mkdir('/home/pi/LIVE/segmented_data/'+str(current_dt))
  os.chdir('/home/pi/LIVE/segmented_data/'+str(current_dt))
  i=0
  while True:
     if ser.in_waiting>0:  # checks if data is available
        path="log" + str(i)+".csv"
        if os.path.exists(path)== False: 
            file=open("log" + str(i)+".csv", 'a', encoding='utf-8-sig')
            x=os.stat(path).st_size
            for x in range (0,200): # write new file every 20 seconds
              obj=csv.writer(file)
              line=ser.readline()
              line=line.decode('utf-8').split()  # decodes line with utf-8 and splits into list
              print(line)  
              obj.writerow(line)
              time.sleep(0.01)  # sampling rate of 100Hz                                                
            file.close()
            i=i+1
        elif os.path.exists(path)== False:  #increments i if file exists
           i=i+1
