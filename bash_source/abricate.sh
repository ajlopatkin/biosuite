#!/bin/bash

# SCRIPT NAME: abricate.sh
# DESCRIPTION: Uses multiple ARG databases to annotate 
# 
# CONDA ENVIRONMENTS USED: abricate_env
# TOOL DEPENDENCIES: abricate, blast
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - path to input fasta file or files
#	+ 2. output_folder - folder for output
#	+ 3. db_type - darabase to use: resfinder; card; plasmidfinder; ncbi (for AMRfinder); vfdb
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
conda activate abricate_env

# Parse the inputs
input_file=$1
output_folder=$2
db_type=$3

###################
#~- MAIN SCRIPT -~#
###################

abricate --db "$db_type" "$input_file" > "$output_folder""$db_type".txt
abricate --summary "$output_folder""$db_type".txt > "$output_folder"summery_"$db_type".txt
