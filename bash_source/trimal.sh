#!/bin/bash

# SCRIPT NAME: trimal.sh
# DESCRIPTION: Trims multi-sequence alignments based on specified method
# 
# CONDA ENVIRONMENTS USED: trimal_env
# TOOL DEPENDENCIES: trimal
# 
# INPUTS (IN ORDER): 
#	+ 1. output_tree - path to output file
#	+ 2. input_aln - input alignment file
#	+ 3. method - gappyout, strict, nogaps, etc. 
#	+ 4. output format - phylip, fasta, clustal
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
conda activate trimal_env

# Parse the inputs
input_aln=$1
output_aln=$2
method=$3		
format=$4		

###################
#~- MAIN SCRIPT -~#
###################
trimal -in "$input_aln" -out "$output_aln" -$method -$format