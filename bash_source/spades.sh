#!/bin/bash

# SCRIPT NAME: spades.sh
# DESCRIPTION: Assembling and aligning
# 
# CONDA ENVIRONMENTS USED: spades_env
# TOOL DEPENDENCIES: snippy
# 
# INPUTS (IN ORDER): 
#	+ 1. fwd_read - forward trimmed read
#	+ 2. rv_read - reverse trimmed read
#	+ 3. output_dir - output directory
#	+ 4. plasmid_flag - 1 or 0 for assembling a plasmid
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
conda activate spades_env

# Parse the inputs
fwd_read=$1
rv_read=$2
output_dir=$3
plasmid_flag=$4

###################
#~- MAIN SCRIPT -~#
###################
#mkdir "$output_dir"spades/

if [[ $plasmid_flag -eq 1 ]]; then
spades.py -1 "$fwd_read" -2 "$rv_read" --plasmid -o "$output_dir"spades
else 
spades.py -1 "$fwd_read" -2 "$rv_read" -o "$output_dir"spades
fi


