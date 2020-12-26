#!/bin/bash

# SCRIPT NAME: amrfinderplus.sh
# DESCRIPTION: Builds phylogenetic tree using gtr method
# 
# CONDA ENVIRONMENTS USED: amrfinderplus_env
# TOOL DEPENDENCIES: amrfinderplus
# 
# INPUTS (IN ORDER): 
#	+ 1. fasta_file - path to input fasta file
#	+ 2. db_flag - p or n
#	+ 3. output_file - file for output data
# 	+ 4. organism - default Escherichia
# DATE UPDATED: 8/22/20
# AUTHOR: Allison Lopatkin

#########################
#~- ENVIRONMENT SETUP -~#
#########################

# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate amrfinderplus_env

# Parse the inputs
fasta_file=$1
db_flag=$2
output_file=$3
organism=$4

###################
#~- MAIN SCRIPT -~#
###################


if [[ $db_flag == n ]]; then
	amrfinder -n "$fasta_file" --organism "$organism" -o "$output_file"
else
	amrfinder -p "$fasta_file" --organism "$organism" -o "$output_file"
fi
