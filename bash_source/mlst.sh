#!/bin/bash

# SCRIPT NAME: mlst.sh
# DESCRIPTION: Assign organism MLST
#
# CONDA ENVIRONMENTS USED: cge_env
# TOOL DEPENDENCIES: mlst database
# 
# INPUTS (IN ORDER): 
#	+ 1. input_fasta - path to fasta file input 
#	+ 2. output_path - path to folder output
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
conda activate cge_env

# Parse the inputs
input_fasta=$1
output_path=$2

###################
#~- MAIN SCRIPT -~#
###################
python "$BIOSUITE_HOME"/bash_source/mlst.py -i "$input_fasta" -o "$outputpath" -s ecoli -p "$BIOSUITE_HOME"/databases/mlst_db -x