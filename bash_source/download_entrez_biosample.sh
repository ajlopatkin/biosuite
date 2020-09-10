#!/bin/bash

# SCRIPT NAME: download_entrez_biosample.sh
# DESCRIPTION: This script downloads a given genome file from NCBI using Entrez Direct using its accession number
# 
# CONDA ENVIRONMENTS USED: entrez_env
# TOOL DEPENDENCIES: entrez-direct
# 
# INPUTS (IN ORDER): 
#	+ 1. acc_id- the BioSample accession ID of the genome to be downloaded
#	+ 2. outputdir - the output directory to store the file
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
outputdir=$2

###################
#~- MAIN SCRIPT -~#
###################

echo "Downloading requested genome via Entrez..."
esearch -db BioSample -query "$acc_id" | elink -target assembly | esummary | grep "FtpPath_GenBank" | sed -r 's|.+>(ftp://ftp.ncbi.nlm.nih.gov/genomes/all/.+/GCA_.+)<.+|\1|' > "$outputdir"list_asm.txt
wget -r -R "index.html" --no-host-directories --cut-dirs=6 -i "$outputdir"list_asm.txt -P "$outputdir"

gca_name=$(basename $(cat "$outputdir"list_asm.txt))
echo "$gca_name,$acc_id" >> "$outputdir"/asm_mapping.txt
rm "$outputdir"list_asm.txt
