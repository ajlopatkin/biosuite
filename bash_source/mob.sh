#!/bin/bash

# SCRIPT NAME: mob.sh
# DESCRIPTION: Classifies mobility groups and incompatibility groups 
# 
# CONDA ENVIRONMENTS USED: mob_env
# TOOL DEPENDENCIES: mob
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - input fasta
#	+ 2. output_dir - output directory only if mob_recon and specify filename if mob_typer
#	+ 3. recon_flag - r if using mob_recon and t if using mob_typer
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
conda activate mob_env

# Parse the inputs
input_file=$1
output_dir=$2
recon_flag=$3

###################
#~- MAIN SCRIPT -~#
###################


if [[ $recon_flag == r ]]; then
	mob_recon --infile "$input_file" --outdir "$output_dir"
else
	mob_typer --infile "$input_file" --outdir "$output_dir"
fi


