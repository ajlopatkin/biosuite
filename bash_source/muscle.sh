#!/bin/bash

# SCRIPT NAME: muscle.sh
# DESCRIPTION: Creates a multiple sequence alignment with input multi-fasta
# 
# CONDA ENVIRONMENTS USED: muscle_env
# TOOL DEPENDENCIES: muscle
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - input multi-fasta file to align
#	+ 2. output_file - output header for fasta and clw format
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
conda activate muscle_env

# Parse the inputs
input_file=$1
output_file=$2

###################
#~- MAIN SCRIPT -~#
###################

muscle -in "$input_file" -fastaout "$output_file".fa -clwout "$output_file".aln -phyiout "$output_file".phy