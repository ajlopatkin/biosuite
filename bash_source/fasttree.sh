#!/bin/bash

# SCRIPT NAME: fasttree.sh
# DESCRIPTION: Builds phylogenetic tree using gtr method
# 
# CONDA ENVIRONMENTS USED: fasttree_env
# TOOL DEPENDENCIES: fasttree
# 
# INPUTS (IN ORDER): 
#	+ 1. output_tree - path to output file
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
conda activate fasttree_env

# Parse the inputs
output_tree=$1
input_aln=$2

###################
#~- MAIN SCRIPT -~#
###################

FastTree -nt -gtr "$input_aln" > "$output_tree"