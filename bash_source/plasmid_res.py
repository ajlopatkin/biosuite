#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sun Jan  3 18:34:39 2021

@author: clairejohnson
"""

import pandas as pd
import os
import argparse

parser = argparse.ArgumentParser()
#input directory: contains output files of all tools run
parser.add_argument('-i', '--input', dest='i',type=str, required=True)
#output directory path: Place to put excel file for this plasmid
parser.add_argument('-o', '--output', dest='output', type=str, required=True)
#name of output file
parser.add_argument('-id', '--file_id', dest='id', type=str, required=True)
#tools to have as columns
parser.add_argument('-t', '--tools', dest='t', type=str, required=True)
args = parser.parse_args()
def rgi():
    line_no = 0
    rgi_codons = []
    with open(args.i + 'RGI.txt', 'r') as rgi_out:
        print("Reading rgi data from: " + str(args.i + 'RGI.txt'))
        for line in rgi_out:
            if line_no != 0:
                line = line.split()
                start_codon = line[2]
                stop_codon = line[4]
                codons = tuple((int(start_codon), int(stop_codon)))
                rgi_codons.append(codons)
            line_no += 1
        rgi_codons.sort()
    return rgi_codons

def amr():
    line_no = 0
    amr_codons = []
    with open(args.i + 'AMR.txt', 'r') as amr_out:
        print("Reading AMRfinder data from: " + str(args.i + 'AMR.txt'))
        for line in amr_out:
            if line_no != 0:
                line = line.split()
                start_codon = line[2]
                stop_codon = line[3]
                amr_codons.append(tuple((int(start_codon), int(stop_codon))))
            line_no +=1
    return amr_codons

def staramr():
    line_no = 0
    star_codons = []
    with open(args.i + 'staramr/detailed_summary.tsv', 'r') as star_out:
        print("Reading *AMR data from: " + str(args.i + 'staramr/detailed_summary.tsv'))
        for line in star_out:
            line = line.split()
            if line_no > 1 and len(line) > 9:
                start_codon = line[7]
                stop_codon = line[8]
                if '|' in start_codon:
                    start_codon = line[8]
                    stop_codon = line[9]
                star_codons.append(tuple((int(start_codon), int(stop_codon))))    
            line_no += 1	
    return star_codons

def prokka():
    prokka_result = pd.read_excel(args.i + 'prokka/' + args.id + '_combined.xlsx')
    return prokka_result[:][2:]

def mob():
    mob_result = []
    line_no = 0
    with open(args.i + 'mobtyper_' + args.id + '_report.txt') as mob_out:
        for line in mob_out:
            line = line.split()
            if line_no>1:
                mob_result = [line[2], line[3], line[4], line[6], line[8], line[10], line[12]]
            line_no+=1
    return mob_result

def main():
    #tools:  rgi, amr, staramr, prokka, mobtyper, plasmidfinder
    rgi = False
    amr = False
    staramr = False
    prokka = False
    mob = False
    pf = False
    rgi_codons = []
    amr_codons = []
    star_codons = []
    if args.t[0] == 'y':
        rgi_codons = rgi()
        rgi = True
    if args.t[1] == 'y':
        amr_codons = amr()
        amr = True
    if args.t[2] == 'y':
        star_codons = staramr()
        staramr = True
    if args.t[3] == 'y':
        prokka_out = prokka()
        prokka = True
    if args.t[4] == 'y':
        mob_out = mob()
        mob = True
    if args.t[5] == 'y':
        pf_out = plasmidfinder()
        pf = True
    
    consensus = set(rgi_codons + amr_codons + star_codons)
    consensus = consensus.sort()
    x = 0
    while x < range(len(consensus) - 1):
        current_start = consensus[x][0]
        current_stop = consensus[x][1]
        next_start = consensus[x + 1][0]
        next_stop = consensus[x + 1][1]
        #If current start token is between next start and stop, take overlap
        if current_start > next_start and current_start < next_stop:
            # Use closer stop codon
            if current_stop > next_stop:
                current_stop = next_stop
            consensus.remove(consensus[x + 1])
            x -= 1
        #if current stop token is between next start and stop, take overlap
        elif current_stop > next_start and current_stop < next_stop:
            # Use closer start codon
            if current_start < next_start:
                current_start = next_start
            consensus.remove(consensus[x + 1])
            x -= 1
        consensus[x][0] = current_start
        consensus[x][1] = current_stop
        x += 1
    lengths = []
    starts = []
    stops = []
    for x in consensus:
        starts.append(x[0])
        stops.append(x[1])
        lengths.append(abs(x[0]-x[1]))
    
        
    #Get output columns for each tool run
    #compare and sort genes found
    
    output_file = args.o + args.id + ".xlsx"
    current_df.to_excel(output_file)
    print("Translated to data excel file in: " + str(output_file))

if __name__ == '__main__':
    main()
