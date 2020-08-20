# needed modules
import serial  # install with "pip3 install pyserial"
import csv  # install with "pip3 install python-csv"
import os

if __name__ == '__main__':
    os.system("sudo mkdir /mnt/usbdisk")
    os.system("sudo mount /dev/sda1 /mnt/usbdisk)
    
    os.system("mkdir ~/LIVE/data_files")
    os.system("cd ~/LIVE/data_files")
    # find correct device with "ls /dev/tty*"
    ser = serial.Serial('/dev/ttyACM0', 9600, timeout=1)  # initializes serial communciations in ser object
    ser.flush()  # flushes any I/O buffer to avoid sending incomplete data at start of serial communication
    
 i=0
 while True:
     if ser.in_waiting > 0:  # checks if data is available
         line=ser.readline()  # reads in all bytes of data
         line=line.decode('utf-8').split()  # decodes line with utf-8 and splits into list
         print(line)  # sanity check - prints each line to terminal
            #csvfile=open('data.csv','a',newline='\n')  # opens csv file
            #obj=csv.writer(csvfile)  # creates csv file object
            #obj.writerow(line)  # writes each line to a new row in csv
            #csvfile.close()
            
          path="data"+ str(i)+ ".csv"
          if os.path.exists("data"+ str(i)+ ".csv")==False:  # to check if the file already exists
              file = open("data"+ str(i)+ ".csv", "a", encoding='utf-8')
              x=os.stat("data"+ str(i)+ ".csv").st_size
              for x in range (0,30):     # to write 30 lines of data into a file
                   obj=csv.writer(file)  # creates csv file object
                   obj.writerow(line)
                   time.sleep(0.5)
              file.close()
              i=i+1                   # to increase the i value 

           i=i+1                    # to increase the valu of i when the file already exists
