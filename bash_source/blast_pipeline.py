#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 22 10:51:11 2021

@author: clairejohnson
"""
import argparse
import pandas as pd
import os

parser = argparse.ArgumentParser()
parser.add_argument('-i', '--input', dest='i',type=str, required=True)
args = parser.parse_args()

def main():
    output_dir = args.i
    input_dir = [f for f in os.listdir(args.i) if os.path.isfile(os.path.join(args.i, f))]
    df = pd.DataFrame()
    for file in input_dir:
        acc_id = file.split("_")[0]
        if "_parsed" not in file and "filtered" not in file and ".DS" not in file:
            cur_df = pd.read_csv(args.i + file, "\t", header=None)
            cur_df.insert(0, "acc_id", acc_id)
            df = pd.concat([df, cur_df], axis=0)
    if 
    df.to_csv(output_dir + "final_out.csv")

if __name__ == '__main__':
    main()
        