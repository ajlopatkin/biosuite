#!/usr/bin/env python3
# updated 8/12/21

import argparse

parser = argparse.ArgumentParser()
#Input directory path
parser.add_argument('-i', '--input_dir', dest='i',type=str, required=True)
#output file path
parser.add_argument('-o', '--output_file', dest='o', type=str, required=True)
args = parser.parse_args()

from Bio import SeqIO
count = 0
long_sequences = []
with open (args.i) as handle:
	for seq_record in SeqIO.parse(handle, format = "fasta"):
		if len(seq_record) > 1000:
			count = count+1
			long_sequences.append(seq_record)

SeqIO.write(long_sequences, args.o, "fasta")
