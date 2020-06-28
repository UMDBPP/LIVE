#!/usr/bin/env python 3

import serial
import csv

ser=serial.Serial('/dev/ttyACM1', 9600,timeout='1')
ser.flush()

while true:
   if ser.in_waiting>0:
           line=ser.readline()
           line.decode('utf-8').split()
           print(line)
           csvfile=open('data.csv','w',newline=' ')
           obj=csv.writer(csvfile)
           obj.writerow(line)
           csvfile.close()
          
          
        
          
          
