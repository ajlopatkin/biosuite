#!/bin/bash

# SCRIPT NAME: raxml.sh
# DESCRIPTION: Builds a tree with a .phy input (output from MUSCLE or CLUSTALO)
# 
# CONDA ENVIRONMENTS USED: raxml_env
# TOOL DEPENDENCIES: muscle
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - input aligned fasta file
#	+ 2. output_dir - directory for output tree
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
conda activate raxml_env

# Parse the inputs
input_file=$1
output_dir=$2

###################
#~- MAIN SCRIPT -~#
###################

raxmlHPC -f a -# 20 -m PROTGAMMAAUTO -p 12345 -x 12345 -s "$input_file" -w "$output_dir" -n output.tree
