import os

direc = input("Enter the absolute filepath that contains the segmented data files: ")
if os.path.isdir(direc) == True:
    numfiles = input("Enter the number of segmented files that need to be merged together: ")
    fout=open("out.csv","a")
    # first file:
    for line in open("log0.csv"):
        fout.write(line)
    # now the rest:    
    for num in range(1,652):
        f = open("log"+str(num)+".csv")
        f.__next__() # skip the header
        for line in f:
            fout.write(line)
        f.close() # not really needed
    fout.close()
