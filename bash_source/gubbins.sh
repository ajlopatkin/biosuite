#!/bin/bash

# SCRIPT NAME: gubbins.sh
# DESCRIPTION: Takes in a multi-fasta alignment and identifies sites of recombination
# 
# CONDA ENVIRONMENTS USED: gubbins_env
# TOOL DEPENDENCIES: muscle
# 
# INPUTS (IN ORDER): 
#	+ 1. multi_fasta_align - input multi-fasta aligned file
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
conda activate gubbins_env

# Parse the inputs
multi_fasta_align=$1

###################
#~- MAIN SCRIPT -~#
###################

run_gubbins.py "$multi_fasta_align"