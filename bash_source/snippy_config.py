# write config for multi snippy
import re
import pandas as pd
import os
import xlrd
import argparse



parser = argparse.ArgumentParser()
parser.add_argument('-s', '--single', dest='s',type=str, required=True)
#Output directory path for csv files
parser.add_argument('-p', '--paired', dest='p',type=str, required=True)
parser.add_argument('-o', '--output', dest='o',type=str, required=True)
args = parser.parse_args()

def get_ID(file):
    if "." in file:
        ID = file.split(".")[0]
    else:
        raise RuntimeError("Invalid file name, no extension found: " + file)
    if "R1" in ID:
        ID = ID.split("R1")[0]
    if "R2" in ID:
        ID = ID.split("R2")[0]
    if ID[-1] == "_":
        ID = ID[0:-1]
    return ID

def validity_check(file):
    if ".f" in file:
        return True
    else:
        return False

def main():
    input_dir_single = os.listdir(args.s)
    input_dir_paired =  os.listdir(args.p)
    out_file = args.o
    
    print("Input Directory passed to config (single read): " + args.s)
    print("Files found: " + str(input_dir_single))
    print("Input Directory passed to config (paired read): " + args.p)
    print("Files found: " + str(input_dir_paired))
    paired_dict = dict()
    for file in input_dir_paired:
        if(validity_check(file)):
            ID = get_ID(file)
            if ID in paired_dict:
                paired_dict[ID].append(file)
            else:
                paired_dict[ID] = [file]    
        else:
            print("Skipping invalid file: " + file)
            
    with open(out_file, "w+") as output:
        for file in input_dir_single:  
            if(validity_check(file)):
                line = get_ID(file) + "\t" + args.s + file
                print(line)
                output.write(line + "\n")
            else:
                print("Skipping invalid file: " + file)
        for ID in paired_dict.keys():
            if len(paired_dict[ID]) == 2:
                line = ID + "\t" + args.p + paired_dict[ID][0] + "\t" + args.p + paired_dict[ID][1]
                print(line)
                output.write(line + "\n")
            else:
                raise RuntimeError("Pair not found for " + ID +". Ensure file names are " + ID + "_R1 and " + ID + "_R2")
    
    
if __name__ == '__main__':
    main()


