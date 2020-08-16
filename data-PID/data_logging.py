'''
Using serial communication, logs all data from PIDcontroller.ino on Arduino onto RPi data.csv
'''

# needed modules #
import serial  # pip3 install pyserial
import csv  # pip3 install python-csv
import time
import os

if __name__ == '__main__':
    # find correct device with "ls /dev/tty*"
    ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)  # initializes serial communciations in ser object
    ser.flush()  # flushes any I/O buffer to avoid sending incomplete data at start of serial communication
    while True:
        if ser.in_waiting > 0:  # checks if data is available
            line=ser.readline()  # reads in all bytes of data
            line=line.decode('utf-8').split()  # decodes line with utf-8 and splits into list
            print(line)  # sanity check - prints each line to terminal
            if line[5] != 'Temp_degC':
                if int(line[5]) >= 82:
                    os.system("sudo shutdown -h now")
            csvfile=open('/home/pi/LIVE/data.csv','a',newline='\n')  # opens csv file
            obj=csv.writer(csvfile)  # creates csv file object
            obj.writerow(line)  # writes each line to a new row in csv
            time.sleep(0.5)
            csvfile.close()
