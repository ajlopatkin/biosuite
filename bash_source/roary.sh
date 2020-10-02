#!/bin/bash

# SCRIPT NAME: roary.sh
# DESCRIPTION: Annotates calculates core and pan and accessory genomes from .gff files
# 
# CONDA ENVIRONMENTS USED: roary_env
# TOOL DEPENDENCIES: roary
# 
# INPUTS (IN ORDER): 
#	+ 1. input_dir - input directory with all .gff files
#	+ 2. output_dir - output directory
#	+ 3. min_blast_pct - minimum blast pct identity
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
conda activate roary_env

# Parse the inputs
input_dir=$1
output_dir=$2
min_blast_pct=$3

###################
#~- MAIN SCRIPT -~#
###################

roary -p 8 --group_limit 60000 -e --mafft -n -r -i "$min_blast_pct" -f "$output_dir" "$input_dir"*.gff
cp "$output_dir"_*/* "$output_dir"/
rm -rf "$output_dir"_*
python $BIOSUITE_HOME/bash_source/roary_plots.py "$output_dir"accessory_binary_genes.fa.newick "$output_dir"gene_presence_absence.csv




