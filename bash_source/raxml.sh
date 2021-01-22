#!/bin/bash

# SCRIPT NAME: raxml.sh
# DESCRIPTION: Builds a tree with a .phy input (output from MUSCLE or CLUSTALO)
# 
# CONDA ENVIRONMENTS USED: raxml_env
# TOOL DEPENDENCIES: muscle
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - input aligned fasta file
#	+ 2. output_dir - directory for output tree
#	+ 3. bootstrap_num - number of bootstrap repetitions
#	+ 4. tree_model - model to use for tree (GTRGAMMA for nucleotide; PROTGAMMAAUTO for amino acid)
#	+ 5. outgroup - accession ID of outgroup
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
conda activate raxml_env

# Parse the inputs
input_file=$1
output_dir=$2
bootstrap_num=$3
tree_model=$4
outgroup=$5

###################
#~- MAIN SCRIPT -~#
###################

if [ "$#" -eq 4 ]; then
	raxmlHPC -f a -# "$bootstrap_num" -m "$tree_model" -p 12345 -x 12345 -s "$input_file" -w "$output_dir" -n output.tree
else
    raxmlHPC -f a -o "$outgroup" -# "$bootstrap_num" -m "$tree_model" -p 12345 -x 12345 -s "$input_file" -w "$output_dir" -n output.tree
fi

###raxmlHPC -f a -o CU928158.2 -# 100 -m PROTGAMMAAUTO -p 12345 -x 12345 -s "$input_file" -w "$output_dir" -n output.tree
