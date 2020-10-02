#!/bin/bash

# SCRIPT NAME: plasmidfinder.sh
# DESCRIPTION: Identified plasmid incompatibility groups from input fasta
# 
# CONDA ENVIRONMENTS USED: plasmidfinder_env
# TOOL DEPENDENCIES: muscle
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - input AA file
#	+ 1. output_dir - output directory
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
conda activate plasmidfinder_env

# Parse the inputs
input_file=$1
output_dir=$2

###################
#~- MAIN SCRIPT -~#
###################

plasmidfinder.py -i "$input_file" -o "$output_dir"