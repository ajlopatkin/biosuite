#!/bin/bash

# SCRIPT NAME: genome_res.sh
# DESCRIPTION: Combines various outputs for a genome into one spreadsheet
# 
# TOOL DEPENDENCIES: resistance_compiler.py
# 
# INPUTS (IN ORDER): 
#	+ 1. input_path - folder of outputs for one .fna file to be combined
#	+ 2. output_path - folder to store compiled output
#	+ 3. id - name of output file
#	+ 4. tools_selected - string of 'y' and 'n' to determine output columns
# 
# DATE UPDATED: 12/04/20
# AUTHOR: Claire Johnson

#########################
#~- ENVIRONMENT SETUP -~#
#########################
# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh

# Parse the inputs
input_path=$1 
output_path=$2 
id=$3
tools_selected=$4

###################
#~- MAIN SCRIPT -~#
###################
python "$BIOSUITE_HOME"/bash_source/genome_res.py -i "$input_path" -o "$output_path" -id "$id" -t "$tools_selected"
