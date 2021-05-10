#!/bin/bash

# SCRIPT NAME: snippy_config.sh
# DESCRIPTION: Generate .tab file for snippy-multi
# 
# CONDA ENVIRONMENTS USED: 
# TOOL DEPENDENCIES: 
# 
# INPUTS (IN ORDER): 
#	+ 1. input_dir_single - input directory with all single read files
#	+ 2. input_dir_paired - input directory with all paired read files
#	+ 3. output_file - path for the python output 
#	+ 4. ref_file - reference file
#	+ 5. output_dir - output directory
# 
# DATE UPDATED: 2/18/2021
# AUTHOR: Claire Johnson

#########################
#~- ENVIRONMENT SETUP -~#
#########################

# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh

# Parse the inputs
input_dir_single=$1
input_dir_paired=$2
output_file=$3
ref_file=$4
output_dir=$5


###################
#~- MAIN SCRIPT -~#
###################
echo "entered bash"
python "$BIOSUITE_HOME"/bash_source/snippy_config.py -s "$input_dir_single" -p "$input_dir_paired" -o "$output_file"
bash "$BIOSUITE_HOME"/bash_source/snippy_multi.sh "$output_file" "$ref_file" "$output_dir"