#!/bin/bash

# SCRIPT NAME: compile_xlsx.sh
# DESCRIPTION: Combines various outputs for a genome into one spreadsheet
# 
# TOOL DEPENDENCIES: excel_compiler.py
# 
# INPUTS (IN ORDER): 
#	+ 1. input_path - folder containing excel sheets to be combined
#	+ 2. output_path - file to store combined output
#	+ 3. type - 'g' (genome), 'p' (plasmid), or 'a' (genome and plasmid)
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
type=$3

###################
#~- MAIN SCRIPT -~#
###################

python "$BIOSUITE_HOME"/bash_source/compile_xlsx.py -i "$input_path" -o "$output_path" -t "$type"