#!/usr/bin/env python3
#needed modules
import serial
import csv
import os
import time
from datetime import datetime



if __name__ =='__main__':
  ser=serial.Serial('/dev/ttyACM0',9600,timeout=1)   # find correct device with "ls /dev/tty*"
  ser.flush()                                        # # flushes any I/O buffer to avoid sending incomplete data at start of serial communication
       
    
# j=1
now = datetime.now()
current_dt = now.strftime("%b-%d-%Y_%H-%M-%S")
if os.path.isdir('/home/pi/LIVE/data_files') == False:
  os.mkdir('/home/pi/LIVE/data_files')
while True:
 if os.path.isdir('/home/pi/LIVE/data_files/'+str(current_dt))==False:      #checking if the directory exists
  os.mkdir('/home/pi/LIVE/data_files/'+str(current_dt))
  os.chdir('/home/pi/LIVE/data_files/'+str(current_dt))                       # changing the path 
  i=0
  while True:
     if ser.in_waiting>0:                                        # checks if data is available                                           # sanity check
        path="log" + str(i)+".csv"
        if os.path.exists(path)== False:                                        #checking if then file exists
            file=open("log" + str(i)+".csv", 'a', encoding='utf-8-sig')         # pening the file
            x=os.stat(path).st_size                                             # size of file
            for x in range (0,40):                                              #writing new file every 30 seconds
              obj=csv.writer(file)
              line=ser.readline()                                      # reads in all bytes of data
              line=line.decode('utf-8').split()                        # decodes line with utf-8 and splits into list
              print(line)  
              obj.writerow(line)
              time.sleep(0.5)                                                      
            file.close()
            i=i+1                                                                 #incrementing the value of i after 30 set of data are written
        elif os.path.exists(path)== False:                                        #incrementing the value of i if the file exists
           i=i+1
 elif os.path.isdir("/home/pi/LIVE/datafile_"+str(j))==True:                      #incrementing the value of j is the directory exists
          j=j+1
       
    
             
             

