#!/bin/bash

# SCRIPT NAME: blast_search.sh
# DESCRIPTION: Creates a local blast database given a multi fasta file input
# 
# CONDA ENVIRONMENTS USED: blast_env
# TOOL DEPENDENCIES: blast
# 
# INPUTS (IN ORDER): 
#	+ 1. query_file - query fasta file to search
#	+ 2. input_blast_db - makeblstdb output file
#	+ 3. output_blast - blast output results file name and path
#	+ 4. output_fasta - output file name and path
#	+ 5. db_flag - protein or nucleotide blast option "p" or "n"
# 
# DATE UPDATED: 8/22/20
# AUTHOR: Allison Lopatkin

#########################
#~- ENVIRONMENT SETUP -~#
#########################

# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate blast_env

# Parse the inputs
query_file=$1
input_blast_db=$2
output_blast=$3
output_fasta=$4
db_flag=$5

###################
#~- MAIN SCRIPT -~#
###################

if [[ $db_flag == n ]]; then
	echo "Using blastn..."
	blastn -query "$query_file"	-db "$input_blast_db" -outfmt 7 -out\
	 "$output_blast" -reward 2 -penalty -3 -word_size 11 -gapopen 5 -gapextend 2
	sed '/^#/ d' < "$output_blast" | head -n 1 > "$output_blast"_parsed
else
	echo "Using blastp..."
	blastp -query "$query_file"	-db "$input_blast_db" -outfmt 7\
	 -out "$output_blast" -reward 2 -penalty -3 -word_size 11 -gapopen 5 -gapextend 2
	sed '/^#/ d' < "$output_blast" | head -n 1 > "$output_blast"_parsed
fi

start=$(cut -d$'\t' -f9 "$output_blast"_parsed)
stop=$(cut -d$'\t' -f10 "$output_blast"_parsed)

if [[ "$stop" -gt "$start" ]]; then
blastdbcmd -db "$input_blast_db" -entry all -range "$start"-"$stop" -out "$output_fasta" 
else
blastdbcmd -db "$input_blast_db" -entry all -range "$stop"-"$start" -out "$output_fasta"_nonrev
fi