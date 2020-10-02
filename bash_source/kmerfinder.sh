#!/bin/bash

# SCRIPT NAME: kmerfinder.sh
# DESCRIPTION: Assign organism kmer group
#
# CONDA ENVIRONMENTS USED: cge_env
# TOOL DEPENDENCIES: kmerfinder and CGE databases
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
python "$BIOSUITE_HOME"/bash_source/kmerfinder.py -i "$input_fasta" -o "$output_path"\
 -db "$BIOSUITE_HOME"/databases/kmerfinder_db/bacteria/bacteria.ATG

