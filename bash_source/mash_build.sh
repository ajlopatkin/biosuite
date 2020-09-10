#!/bin/bash

# SCRIPT NAME: mash_build.sh
# DESCRIPTION: Build a MASH database
# 
# CONDA ENVIRONMENTS USED: mash_env
# TOOL DEPENDENCIES: mash
# 
# INPUTS (IN ORDER): 
#	+ 1. output_file - output MASH database name
#	+ 2. input_genomes - input genome fasta files
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
conda activate mash_env

# Parse the inputs
output_file=$1
input_genomes="${@:2}"

###################
#~- MAIN SCRIPT -~#
###################

mash sketch -o "$output_file" "$input_genomes"
