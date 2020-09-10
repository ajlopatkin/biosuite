#!/bin/bash

# SCRIPT NAME: mash_cluster.sh
# DESCRIPTION: Clusters genomes according to their mash distance
# 
# CONDA ENVIRONMENTS USED: mash_cluster_env
# TOOL DEPENDENCIES: sci-kitlearn pyclustering seaborn numpy
# 
# INPUTS (IN ORDER): 
#	+ 1. input_file - path to mash square output and incldue file name 
#	+ 2. output_file - path to file and incldue file name
#	+ 3. color_file - path to color file that matches order of mash distance file
#
# OUTPUTS:
#	+ None
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
conda activate mash_cluster_env

# Parse the inputs
input_file=$1
output_file=$2
color_file=$3

###################
#~- MAIN SCRIPT -~#
###################

python "$BIOSUITE_HOME"/bash_source/mash_cluster.py -i "$input_file" -o "$output_file" -b "$color_file" -m silhouette
