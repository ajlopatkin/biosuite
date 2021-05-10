#!/bin/bash

# SCRIPT NAME: blast_search.sh
# DESCRIPTION: Creates a local blast database given a multi fasta file input
# 
# CONDA ENVIRONMENTS USED: blast_env
# TOOL DEPENDENCIES: blast
# 
# INPUTS (IN ORDER): 
#	+ 1. input_dir - fasta file or files
#	+ 2. database - path to KL or OCL database file (.gbk)
#	+ 3. output_dir - path/prefix for output files
# 
# DATE UPDATED: 4/4/21
# AUTHOR: Claire Johnson

#########################
#~- ENVIRONMENT SETUP -~#
#########################


# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environments
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate kaptive_env

#Parse Inputs
input_dir=$1
database=$2
output_dir=$3

###################
#~- MAIN SCRIPT -~#
###################

python3 "$BIOSUITE_HOME"/bash_source/kaptive.py -a "$input_dir" -k "$database" -o "$output_dir"

