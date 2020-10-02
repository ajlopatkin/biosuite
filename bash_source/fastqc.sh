#!/bin/bash

# SCRIPT NAME: fastqc.sh
# DESCRIPTION: Reports on fastq quality
# 
# CONDA ENVIRONMENTS USED: qc_env
# TOOL DEPENDENCIES: fastqc
# 
# INPUTS (IN ORDER): 
#	+ 1. fwd_read - full path name of forward read
#	+ 2. rv_read - full path name of forward read
#	+ 3. output_dir - output directory
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
fwd_read=$1
rv_read=$2
output_dir=$3

###################
#~- MAIN SCRIPT -~#
###################

fastqc "$fwd_read" "$rv_read" -o "$output_dir"
