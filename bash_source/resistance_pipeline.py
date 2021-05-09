#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Feb  4 12:24:08 2021

@author: clairejohnson
"""

#Read in all the files in the folder as separate tables

#Make a set of all of the gene columns 

import argparse
import os
import pandas as pd
from collections import defaultdict 

parser = argparse.ArgumentParser()
#Input directory holding consensus files
parser.add_argument('-i', '--input', dest='i',type=str, required=True)
#Output directory path for csv files
parser.add_argument('-o', '--output', dest='o',type=str, required=True)
parser.add_argument('-t', '--type', dest='t', type=str, required=False)
parser.add_argument('-m', '--mask', dest='m', type=str, required=False)
args = parser.parse_args()

def main():
    mask = []
    if args.t is not None:
        if args.t == 'a':
            mask = ['abeM','Acinetobacter_baumannii_AbaQ','adeL','adeF','adeG','adeH','abeS','blaOXA-107','blaOXA-69','adeJ','adeN','adeK','blaOXA-164','blaOXA-371','adeI','blaOXA-167','blaOXA-92','adeS','adeR','adeC','adeB','adeA','blaADC-5','blaADC-184','blaADC-38','blaADC-174','blaADC-79','blaADC-78','blaADC-30','blaADC-81','blaADC-53','blaADC-74','blaADC-6','blaADC-183','blaADC-176','blaADC-11','blaADC-185','blaADC-96','blaADC-235','blaADC-25','blaADC-182','blaADC-186','blaADC-191','blaADC-181','blaADC-175']
        elif args.t=='e':
            mask = []
        elif args.t == 'o':
            if len(m) > 0:
                mask = m.split(" ")
            else:
                print("No custom mask passed to pipeline, running without mask")
        else:
            mask=[]
            print("No species flag, running without mask")
    tables = dict()
    set_genes = []
    set_res = []
    #Read tables
    files = os.listdir(args.i)
    res_dict = defaultdict(list)
    for file in files:
        if file[-3:] == "csv":
            df = pd.read_csv(args.i + file)
            for index, row in df.iterrows():
                cur_gene = row["GENE_CONSENSUS"]
                cur_drug = row["RESISTANCE_CONSENSUS"]
                if cur_gene not in mask:
                    res_dict[cur_drug].append(cur_gene)
                    set_genes.append(cur_gene)
                    set_res.append(cur_drug)
                else:
                    df.drop(index, inplace=True)
            tables[file[:-4]] = df
            
    
    for k in res_dict.keys():
        v = res_dict[k]
        v = list(set(v))
        #print("Drug class: " + k )
        #print(*v, sep=', ')
    
    #Make sets 
    set_genes = list(set(set_genes))
    for gene in mask:
       if gene in set_genes:
            set_genes.remove(gene)
    set_res = list(set(set_res))
    genes_df = pd.DataFrame(columns=(["BioSample"] + set_genes))
    res_df = pd.DataFrame(columns=(["BioSample"] + set_res))
    pairs_df = pd.DataFrame(columns=(["BioSample"] + set_res))
    
    gene_dict = dict()
    for res in set_res:
        gene_dict[res] = []
        
    for k, v in tables.items():
        print(k)
        current_res = pd.DataFrame(columns=(["BioSample"] + set_res))
        current_pairs = [k]
        current_genes = [k]
        current_res = [k]
        if len(v) > 0:
            for gene in set_genes:
                if gene in v["GENE_CONSENSUS"].tolist():
                    current_genes.append(1)
                else:
                    current_genes.append(0)
            for res in set_res:
                if res in v["RESISTANCE_CONSENSUS"].tolist():
                    current_res.append(1)
                    current_pairs.append(v["RESISTANCE_CONSENSUS"].tolist().count(res))
                else:
                    current_res.append(0)
                    current_pairs.append(0)
        else:
            for i in range(len(genes_df.columns) - 1):
                current_genes.append(0)
            for i in range(len(res_df.columns) - 1):
                current_res.append(0)
                current_pairs.append(0)
            
        genes_df.loc[len(genes_df)] = current_genes
        res_df.loc[len(res_df)] = current_res
        #print(current_pairs)
        pairs_df.loc[len(pairs_df)] = current_pairs
        
    genes_df.to_csv(args.o + "resistance_gene_heatmap_table.csv")
    res_df.to_csv(args.o + "resistance_drug_heatmap_table.csv")
    pairs_df.to_csv(args.o + "gene_counts_heatmap_table.csv")


if __name__ == '__main__':
    main()