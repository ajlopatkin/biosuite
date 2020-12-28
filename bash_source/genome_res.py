#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Oct 30 16:38:58 2020

@author: clairejohnson
"""

import pandas as pd
import os
import argparse

parser = argparse.ArgumentParser()
#Input directory path
parser.add_argument('-i', '--input', dest='i',type=str, required=True)
#output directory path
parser.add_argument('-o', '--output', dest='output', type=str, required=True)
#name of output file
parser.add_argument('-id', '--file_id', dest='id', type=str, required=True)
#tools to run
parser.add_argument('-t', '--tools', dest='t', type=str, required=True)
args = parser.parse_args()

def rgi():
    #Read RGI data
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

def amrfinder():
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

def mlst():
    sequence_type = None
    with open(args.i + 'mlst/st_results.txt', 'r') as mlst_out:
        print("Reading MLST data from: " + str(args.i + 'mlst/st_results.txt'))
        for line in mlst_out:
            if 'Sequence' in line:
                line = line.split()
                sequence_type = line[-1]
    return sequence_type
                
def kmer():
    kmer_out = None
    with open(args.i + 'kmer_results.csv', 'r') as kmer_out:
        print("Reading Kmerfinder data from: " + str(args.i + 'kmer_results.txt'))
        for line in kmer_out:
            #finish this
    return kmer_out

def clermont():
    clermont_type = None
    with open(args.i + 'clermont.txt') as clermont_out:
        for line in clermont_out:
            line = line.split()
            if len(line) == 2:
                clermont_type = line[-1]
    return clermont_type
                
                
def main():       
    column_list = []
    rgi_codons = []
    star_codons = []
    rgi = False
    star = False
    amr = False
    amr_codons = []
    all_codons = []
    
    if args.t[4] == 'y':
        sequence_out = mlst()
        columnn_list.append('Sequence Type')
        mlst = True
    
    if args.t[0] == 'y':
        rgi_codons = rgi()
        rgi = True
        columnn_list.append('rgi')
        all_codons = all_codons + rgi_codons
        
    if args.t[2] == 'y':
        amr_codons = amrfinder()
        amrfinder = True;
        columnn_list.append('AMRfinder')
        all_codons = all_codons + amr_codons
    
    if args.t[1] == 'y':
        star_codons = staramr()
        staramr = True
        columnn_list.append('*AMR')
        all_codons = all_codons + star_codons

    if args.t[3] == 'y':
        clermont_out = clermont()
        columnn_list.append('Phylogroup')
        clermont = True
        
    if args.t[5] == 'y':
        kmer_out = kmer()
        columnn_list.append('Kmer finder')
        kmer = True
    
    
    all_codons = list(set(all_codons))
    all_codons.sort()
    
    if len(all_codons) > 0:
        i = 0
        #Find overlaps
        copies_found = 0
        while i < len(all_codons) - 1:
            current = all_codons[i]
            nxt = all_codons[i + 1]
            
            if isinstance(current, list):
                for gene in current:
                    if (int(nxt[0]) >= gene[0] and int(nxt[0]) <= gene[1]) or int(nxt[1]) >=  gene[0] and int(nxt[1]) <= gene[1]:
                        all_codons[i].append(nxt)
                        all_codons.pop(i + 1)
                        copies_found += 1
                i += 1
            elif int(nxt[0]) >= gene[0] and int(nxt[0]) <= gene[1]) or int(nxt[1]) >=  gene[0] and int(nxt[1]) <= gene[1]:
                all_codons[i] = [all_codons[i], all_codons[i + 1]]
                all_codons.pop(i + 1)
                copies_found += 1
            
            else:
                i += 1
        
        rgi_df = [None] * len(all_codons)
        amr_df = [None] * len(all_codons)
        star_df = [None] * len(all_codons)

        for i in range(len(all_codons)):
            if isinstance(all_codons[i], list):
                for codon in all_codons[i]:
                    if codon in amr_codons:
                        amr_df[i] = codon
                    if codon in rgi_codons:
                        rgi_df[i] = codon
                    if codon in star_codons:
                        star_df[i] = codon
            else:
                if all_codons[i] in amr_codons:
                    amr_df[i] = all_codons[i]
                if all_codons[i] in rgi_codons:
                    rgi_df[i] = all_codons[i]
                if all_codons[i] in star_codons:
                    star_df[i] = all_codons[i]
        
    current_df = pd.DataFrame(index=(range(len(all_codons) + 1)), columns=(i for i in columnn_list))
    current_df.iloc[0, 0] = sequence_type
    
    
    
    for i in range(len(all_codons)):
        columns = len(columnn_list)
        if mlst:
            current_df.iloc[i + 1, len(columnn_list - columns)] = sequence_out
            columns -= 1
        if rgi:
            current_df.iloc[i + 1, len(columnn_list - columns)] = rgi_df[i]
            columns -= 1
        if amr:
            current_df.iloc[i + 1, len(columnn_list - columns)] = amr_df[i]
            columns -= 1
        if star:
            current_df.iloc[i + 1, len(columnn_list - columns)] = star_df[i]
            columns -= 1
        if clermont:
            current_df.iloc[i + 1, len(columnn_list - columns)] = clermont_out
            columns -= 1
        if kmer:
            current_df.iloc[i + 1, len(columnn_list - columns)] = kmer_out
            columns -= 1
    
    output_file = args.o + args.id + ".xlsx"
    current_df.to_excel(output_file)
    print("Translated to data excel file in: " + str(output_file))
    

if __name__ == '__main__':
    main()
