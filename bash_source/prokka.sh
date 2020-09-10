#!/bin/bash

# SCRIPT NAME: prokka.sh
# DESCRIPTION: Annotates files with fasta input
# 
# CONDA ENVIRONMENTS USED: prokka_env
# TOOL DEPENDENCIES: prokka
# 
# INPUTS (IN ORDER): 
#	+ 1. input_fasta - input file to annotate
#	+ 2. output_dir - directory
#	+ 3. prefix_name - file prefix
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
input_fasta=$1
output_dir=$2
prefix_name=$3

###################
#~- MAIN SCRIPT -~#
###################

prokka --kingdom Bacteria --outdir "$output_dir" --prefix "$prefix_name"\
 --force --genus Escherichia "$input_fasta"
python "$BIOSUITE_HOME"/bash_source/prokka2kegg.py -i "$output_dir"*.gbf\
 -d "$BIOSUITE_HOME"/databases/idmapping_KO.tab.gz -o "$output_dir"prokka2keg.txt
