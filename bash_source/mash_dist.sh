#!/bin/bash

# SCRIPT NAME: mash_dist.sh
# DESCRIPTION: Build a MASH database
# 
# CONDA ENVIRONMENTS USED: mash_env
# TOOL DEPENDENCIES: mash
# 
# INPUTS (IN ORDER): 
#	+ 1. mash_DB - input MASH database name
#	+ 2. fasta_files - input genome fasta files
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
mash_DB=$1
fasta_files=$2

###################
#~- MAIN SCRIPT -~#
###################

mash dist "$mash_DB" "$fasta_files"