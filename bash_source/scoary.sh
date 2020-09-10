#!/bin/bash

# SCRIPT NAME: scoary.sh
# DESCRIPTION: Annotates calculates core and pan and accessory genomes from .gff files
# 
# CONDA ENVIRONMENTS USED: roary_env
# TOOL DEPENDENCIES: scoary
# 
# INPUTS (IN ORDER): 
#	+ 1. gene_presence_absence_path - path to gene_presence_absence.csv from Roary output
#	+ 2. traits_path - path to traits.csv
#	+ 3. output_dir - output_directory
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
conda activate roary_env

# Parse the inputs
gene_presence_absence_path=$1
traits_path=$2
output_dir=$3

###################
#~- MAIN SCRIPT -~#
###################

scoary -g "$gene_presence_absence_path" -t "$traits_path" -o "$output_dir"