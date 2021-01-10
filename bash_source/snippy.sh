#!/bin/bash

# SCRIPT NAME: snippy.sh
# DESCRIPTION: SNP calling with reference file
# 
# CONDA ENVIRONMENTS USED: snippy_env
# TOOL DEPENDENCIES: snippy
# 
# INPUTS (IN ORDER): 
#	+ 1. input_dir - input directory with all .gff files
#	+ 2. ref_file - reference file
#	+ 3. output_dir - output directory
#	+ 4. prefix - prefix to annotate scoary
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
conda activate snippy_env

# Parse the inputs
input_file=$1
ref_file=$2
output_dir=$3
prefix=$4

###################
#~- MAIN SCRIPT -~#
###################

snippy --force --cleanup --outdir "$output_dir" --reference "$ref_file" --ctgs "$input_file" --prefix "$prefix" --rgid "$prefix"
