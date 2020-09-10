#!/bin/bash

# SCRIPT NAME: mash_single.sh
# DESCRIPTION: This script creates a mash sketch all downloaded assemlies for QC
# 
# CONDA ENVIRONMENTS USED: mash_env
# TOOL DEPENDENCIES: mash
# 
# INPUTS (IN ORDER): 
#	+ mash_output- Path and file name for mash pairwise distances output
#	+ input_folder- folder containing fastas to be sketched
#	+ db_name - name of mash sketch to be created
# 
# DATE UPDATED: 8/25/20
# AUTHOR: Allison Lopatkin

#########################
#~- ENVIRONMENT SETUP -~#
#########################

# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate mash_env

# Parse the inputs
mash_output="$1"
input_folder="$2"
db_name="$3"

###################
#~- MAIN SCRIPT -~#
###################

# run mash sketching 
mash sketch -s 10000 -o "$BIOSUITE_HOME"/databases/"$db_name" "$input_folder"/*.fna.gz
mash dist "$BIOSUITE_HOME"/databases/"$db_name".msh "$BIOSUITE_HOME"/databases/"$db_name".msh > "$mash_output"