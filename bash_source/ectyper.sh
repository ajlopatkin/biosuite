#!/bin/bash

# SCRIPT NAME: ectyper.sh
# DESCRIPTION: Get clermont phylotypes
# 
# CONDA ENVIRONMENTS USED: ectyper_env
# TOOL DEPENDENCIES: ectyper
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - full path to fasta
#	+ 2. output_folder - full path to output folder
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
conda activate ectyper_env

# Parse the inputs
input_file=$1
output_folder=$2

###################
#~- MAIN SCRIPT -~#
###################

ectyper -i "$input_file" -o "$output_folder"