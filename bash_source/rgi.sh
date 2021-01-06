#!/bin/bash

# SCRIPT NAME: rgi.sh
# DESCRIPTION: Uses CARDS database to ID ARGs
# 
# CONDA ENVIRONMENTS USED: rgi_env
# TOOL DEPENDENCIES: rgi
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - path to input fasta file
#	+ 2. input_aln - input alignment file
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
conda activate rgi_env

# Parse the inputs
input_file=$1
output_file=$2

###################
#~- MAIN SCRIPT -~#
###################

rgi load --card_json "$BIOSUITE_HOME/databases/card.json"
rgi main --input_sequence "$input_file" -o "$output_file" --input_type contig --clean --debug
