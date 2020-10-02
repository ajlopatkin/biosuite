#!/bin/bash

# SCRIPT NAME: staramr.sh
# DESCRIPTION: MLST, resfinder, plasmidfinder
# 
# CONDA ENVIRONMENTS USED: staramr_env
# TOOL DEPENDENCIES: staramr
# 
# INPUTS (IN ORDER): 
#	+ 1. output_dir - output directory
#	+ 2. input_dir - input fasta file
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
conda activate staramr_env

# Parse the inputs
output_dir=$1
input_dir=$2

###################
#~- MAIN SCRIPT -~#
###################

staramr search -o "$output_dir" "$input_dir"
