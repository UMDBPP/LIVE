#!/usr/bin/env python3


import serial
import csv
import os
import time
from datetime import datetime


if __name__ =='__main__':
  ser=serial.Serial('/dev/ttyACM0',9600,timeout=1)
  ser.flush()
       
now=datetime.now()
tstamp="{0:%Y}-{0:%m}-{0:%d}_{0:%H}.{0:%M}.{0:%S}".format(now)
j=1
while True:
 if os.path.isdir('/home/pi/live/datafile_'+str(j))==False:
  os.mkdir('/home/pi/live/datafile_'+str(j))
  os.chdir('/home/pi/live/datafile_'+str(j))
  i=0
  while True:
     if ser.in_waiting>0:
        line=ser.readline()
        line=line.decode('utf-8').split()
        print (line)
        print (tstamp)
        path="log" + str(i)+".csv"
        if os.path.exists(path)== False:
            file=open("log" + str(i)+".csv", 'a', encoding='utf-8-sig')
            x=os.stat(path).st_size
            for x in range (0,30):
              obj=csv.writer(file)
              datetime.now()
              obj.writerow(tstamp)
              obj.writerow(line)
              time.sleep(0.5)
            file.close()
            i=i+1
        elif os.path.exists(path)== False:
           i=i+1
 elif os.path.isdir("/home/pi/live/datafile_"+str(j))==True:
          j=j+1
       
    
             
             
