#!/bin/bash

# SCRIPT NAME: quast.sh
# DESCRIPTION: Assess quality of fasta alignment 
# 
# CONDA ENVIRONMENTS USED: qc_env
# TOOL DEPENDENCIES: quast
# 
# INPUTS (IN ORDER): 
#	+ 1. fasta_scaffold - input file of fasta assembly
#	+ 2. output_folder - new non-existent folder for data output
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
conda activate qc_env

# Parse the inputs
fasta_scaffold=$1
output_folder=$2

###################
#~- MAIN SCRIPT -~#
###################

quast.py "$fasta_scaffold" -o "$output_folder"

