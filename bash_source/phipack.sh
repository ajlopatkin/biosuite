#!/bin/bash

# SCRIPT NAME: phipack.sh
# DESCRIPTION: Takes in a multi-fasta alignment and identifies sites of recombination
# 
# CONDA ENVIRONMENTS USED: phipack_env
# TOOL DEPENDENCIES: muscle
# 
# INPUTS (IN ORDER): 
#	+ 1. multi_fasta_align - input multi-fasta aligned file
#	+ 2. output_file - output file for statistics
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
conda activate phipack_env

# Parse the inputs
multi_fasta_align=$1
output_file=$2

###################
#~- MAIN SCRIPT -~#
###################

Phi -f "$multi_fasta_align" -o "$output_file"