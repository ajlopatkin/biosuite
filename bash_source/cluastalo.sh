#!/bin/bash

# SCRIPT NAME: clustalo.sh
# DESCRIPTION: Performs multiple sequence alignment and outputs fasta or phyl
# 
# CONDA ENVIRONMENTS USED: clustal_env
# TOOL DEPENDENCIES: muscle
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - input multi-fasta file to align
#	+ 2. output_dir - output header for fasta and clw format
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
conda activate clustal_env

# Parse the inputs
input_file=$1
output_dir=$2

###################
#~- MAIN SCRIPT -~#
###################

clustalo -i "$input_file" -o "$output_dir"_clustalo.phy --outfmt phy -v
clustalo -i "$input_file" -o "$output_dir"_clustalo.fasta -v