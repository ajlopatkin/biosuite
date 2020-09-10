#!/bin/bash

# SCRIPT NAME: breseq.sh
# DESCRIPTION: Aligns fastq files to reference genome
# 
# CONDA ENVIRONMENTS USED: breseq_env
# TOOL DEPENDENCIES: breseq
# 
# INPUTS (IN ORDER): 
#	+ 1. ref_gbk - GBK reference file to align to
#	+ 2. fwd_read - fwd fastq file
#	+ 3. rv_read - reverse fastq file
#	+ 4. out_dir - output directory
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
conda activate breseq_env

# Parse the inputs
ref_gbk=$1
fwd_read=$2
rv_read=$3
out_dir=$4

###################
#~- MAIN SCRIPT -~#
###################

breseq -r "$ref_gbk" "$fwd_read" "$rv_read" -o "$out_dir"
