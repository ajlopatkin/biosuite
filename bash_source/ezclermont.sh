#!/bin/bash

# SCRIPT NAME: ezclermont.sh
# DESCRIPTION: Get clermont phylotypes
# 
# CONDA ENVIRONMENTS USED: ezclermont_env
# TOOL DEPENDENCIES: ezclermont
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - full path to fasta
#	+ 2. output_file - full path to tab-delimited clermont output
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
conda activate ezclermont_env

# Parse the inputs
input_file=$1
output_file=$2

###################
#~- MAIN SCRIPT -~#
###################

ezclermont "$input_file" > "$output_file"