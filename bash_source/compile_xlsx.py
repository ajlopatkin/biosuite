#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Dec  6 16:39:07 2020

@author: clairejohnson
"""
import pandas as pd
import argparse
import os

parser = argparse.ArgumentParser()
#Input directory path
parser.add_argument('-i', '--input_dir', dest='i',type=str, required=True)
#output file path
parser.add_argument('-o', '--output_file', dest='o', type=str, required=True)
args = parser.parse_args()

def main():
    result = pd.DataFrame()
    for filename in os.listdir(args.i):
        if filename.endswith(".xlsx"):
            current = pd.read_excel(filename)
            if current.columns == result.columns:
                result.append(current)

    out = result.to_excel(args.o)
    
    
    
if __name__ == '__main__':
    main()