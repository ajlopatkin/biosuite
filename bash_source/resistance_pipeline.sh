#!/bin/bash

# SCRIPT NAME: amrfinderplus.sh
# DESCRIPTION: Finds gene 
# 
# INPUTS (IN ORDER): 
#	+ 1. fasta_file - path to input fasta file
#	+ 2. db_flag - p or n
#	+ 3. output_file - file for output data
# 
# DATE UPDATED: 3/24/21
# AUTHOR: Claire Johnson

#########################
#~- ENVIRONMENT SETUP -~#
#########################

# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh

# Parse the inputs
input_dir=$1
output_dir=$2
species=$3
mask=$4

###################
#~- MAIN SCRIPT -~#
###################

python "$BIOSUITE_HOME"/bash_source/resistance_pipeline.py -i "$input_dir" -o "$output_dir" -t "$species" -m "$mask"
