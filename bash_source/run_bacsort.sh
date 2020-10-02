#!/bin/bash

# SCRIPT NAME: run_bacsort.sh
# DESCRIPTION: This script runs several BacSort utilities. It must be run from the 
#			   parent directory of the fasta folder.
# 
# CONDA ENVIRONMENTS USED: bacsort_env
# TOOL DEPENDENCIES: mash
# 
# INPUTS (IN ORDER): 
#	N/A
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
conda activate bacsort_env

###################
#~- MAIN SCRIPT -~#
###################

python "$BIOSUITE_HOME"/bash_source/bacsort/cluster_genera.py .
bash "$BIOSUITE_HOME"/bash_source/bacsort/mash_distance_matrix.sh 4
Rscript "$BIOSUITE_HOME"/bash_source/bacsort/bionj_tree.R tree/mash.phylip tree/tree.newick
