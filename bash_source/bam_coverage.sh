#!/bin/bash

# SCRIPT NAME: coverage.sh
# DESCRIPTION: Calculates coverage from a BAM file

# CONDA ENVIRONMENTS USED: samtools_env
# TOOL DEPENDENCIES: bwa and samtools
# 
# INPUTS (IN ORDER): 
#	+ 1. fwd_read - full path name of forward read
#	+ 2. reference_file - path to reference file for alignment in .fasta, .fna, or .fa format
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
conda activate samtools_env

# Parse the inputs
sorted_bam=$1
output_dir=$2

###################
#~- MAIN SCRIPT -~#
###################

samtools depth $sorted_bam  |  awk '{sum+=$3} END { print "Average = ",sum/NR}' > $output_dir/coverage.txt
