#!/bin/bash

# SCRIPT NAME: snpsites.sh
# DESCRIPTION: Calls snp sites from alignment file
# 
# CONDA ENVIRONMENTS USED: snpsites_env
# TOOL DEPENDENCIES: snp-sites
# 
# INPUTS (IN ORDER): 
#	+ 1. output_file - output path and file name
#	+ 2. input_file - input aligned fasta file
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
conda activate snpsites_env

# Parse the inputs
output_file=$1
input_file=$2

###################
#~- MAIN SCRIPT -~#
###################
snp-sites -c -p -o "$output_file" "$input_file"
