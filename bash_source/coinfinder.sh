#!/bin/bash

# SCRIPT NAME: coinfinder.sh
# DESCRIPTION: Significantly associated genes
# 
# CONDA ENVIRONMENTS USED: coinfinder_env
# TOOL DEPENDENCIES: coinfinder
# 
# INPUTS (IN ORDER): 
#	+ 1. input_csv - gene presence or absence csv from roary
#	+ 2. input_phylo - roary phylogenetic tree
#	+ 3. output_pref - output path
#
# OUTPUTS:
#	+ None
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
conda activate coinfinder_env

# Parse the inputs
input_csv=$1
input_phylo=$2
output_dir=$3

###################
#~- MAIN SCRIPT -~#
###################

./binaries/coinfinder -I "$input_csv" -p "$input_phylo" -o "$output_dir"