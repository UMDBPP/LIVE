'''
Using serial communication, logs all data from PIDcontroller.ino on Arduino onto RPi data.csv
'''

# shebang for python3, reccomended to run this software with python 3.5.3
# !/usr/bin/env python 3
$ sudo mkdir /mnt/ramdisk    # storing the data to RAM
$ sudo mount -t tmpfs none /mnt/ramdisk

# needed modules
import serial  # install with "pip3 install pyserial"
import csv  # install with "pip3 install python-csv"

if __name__ == '__main__':
    # find correct device with "ls /dev/tty*"
    ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)  # initializes serial communciations in ser object
    ser.flush()  # flushes any I/O buffer to avoid sending incomplete data at start of serial communication
    while True:
        if ser.in_waiting > 0:  # checks if data is available
            line=ser.readline()  # reads in all bytes of data
            line=line.decode('utf-8').split()  # decodes line with utf-8 and splits into list
            print(line)  # sanity check - prints each line to terminal
            #csvfile=open('data.csv','a',newline='\n')  # opens csv file
            #obj=csv.writer(csvfile)  # creates csv file object
            #obj.writerow(line)  # writes each line to a new row in csv
            #csvfile.close()
            i=0
            path="data"+ str(i)+ ".csv"
            for i in range (10):
              if os.path.exists("data"+ str(i)+ ".csv")==False:  # to check if the file already exists
                file = open("data"+ str(i)+ ".csv", "a", encoding='utf-8')
                x=os.stat("data"+ str(i)+ ".csv").st_size
                for x in range (0,3):     # to write 3 lines of data into a file
                   file.write(str(line))
                file.close()
                i=i+1                   # to increase the i value 

              i=i+1                    # to increase the valu of i when the file already exists
            
           
