#!/bin/bash

# SCRIPT NAME: bio_template.sh
# DESCRIPTION: This is a template for bioinformatics scripts.
# 
# CONDA ENVIRONMENTS USED: prokka_env
# TOOL DEPENDENCIES: prokka
# 
# INPUTS (IN ORDER): 
#	+ name_to_echo- the name that will be echoed
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
conda activate prokka_env

# Parse the inputs
name_to_echo=$1

###################
#~- MAIN SCRIPT -~#
###################

prokka -v
echo "Hello, $name_to_echo!"