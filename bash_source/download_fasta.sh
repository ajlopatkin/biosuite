#!/bin/bash

# SCRIPT NAME: download_fasta.sh
# DESCRIPTION: This script downloads a given genome fasta from NCBI using Entrez Direct.
# 
# CONDA ENVIRONMENTS USED: entrez_env
# TOOL DEPENDENCIES: entrez-direct
# 
# INPUTS (IN ORDER): 
#	+ acc_id- the accession ID of the genome to be downloaded
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
conda activate entrez_env

# Parse the inputs
acc_id=$1

###################
#~- MAIN SCRIPT -~#
###################

echo "Downloading requested genome via Entrez..."
efetch efetch -db nucleotide -id "$acc_id" -format fasta > "$acc_id".fasta