#!/bin/bash

# SCRIPT NAME: bbnorm.sh
# DESCRIPTION: Normalizes reads with specified threshold level

# CONDA ENVIRONMENTS USED: bb_env
# TOOL DEPENDENCIES: bbnorm
# 
# INPUTS (IN ORDER): 
#	+ 1. fwd_read - full path name of forward read
#	+ 2. output_dir - output directory
#	+ 3. target_read_depth - target read depth for normalization
# 
# DATE UPDATED: 9/03/21
# AUTHOR: Allison Lopatkin

#########################
#~- ENVIRONMENT SETUP -~#
#########################

# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate bb_env

# Parse the inputs
fwd_read=$1
output_dir=$2
target_read_depth=$3

###################
#~- MAIN SCRIPT -~#
###################
rev_read=$(echo $fwd_read | sed -e "s/_1/_2/g")
forwardread=$(basename "$fwd_read")
extension="${forwardread##*.}"
forwardread="${forwardread%.*}"
reverseread=$(echo $forwardread | sed -e "s/_1/_2/g")
input_dir=$(dirname $fwd_read)/

bbnorm.sh in=$fwd_read in2=$rev_read out=$output_dir/$forwardread.normalized.$extension out2=$output_dir/$reverseread.normalized.$extension target=$target_read_depth

