#!/bin/bash

# SCRIPT NAME: download_entrez.sh
# DESCRIPTION: This script downloads a given genome file from NCBI using Entrez Direct using its accession number
# 
# CONDA ENVIRONMENTS USED: entrez_env
# TOOL DEPENDENCIES: entrez-direct
# 
# INPUTS (IN ORDER): 
#	+ 1. acc_id- the accession ID of the genome to be downloaded
# 	+ 2. format- the format of the downloaded file (fasta, genbank)
#	+ 3. database - name of db to download from (nucleotide or protein likely)
#	+ 4. outputdir - the output directory to store the file
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
format=$2
database=$3
outputdir=$4

###################
#~- MAIN SCRIPT -~#
###################

echo "Downloading requested genome via Entrez..."
efetch -db "$database" -id "$acc_id" -format "$format" > "$outputdir/$acc_id.$format"