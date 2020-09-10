#!/bin/bash

# SCRIPT NAME: make_blast_db.sh
# DESCRIPTION: Creates a local blast database given a multi fasta file input
# 
# CONDA ENVIRONMENTS USED: blast_env
# TOOL DEPENDENCIES: blast
# 
# INPUTS (IN ORDER): 
#	+ 1. input_fasta - name of multi .fasta file
#	+ 2. fasta_type - nucl or prot
#	+ 3. output_dir - output directory for local blast db
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
input_fasta=$1
fasta_type=$2
output_dir=$3

###################
#~- MAIN SCRIPT -~#
###################

makeblastdb -in "$input_fasta" -dbtype "$fasta_type" -parse_seqids -out "$output_dir"	
