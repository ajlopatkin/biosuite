#!/bin/bash

# SCRIPT NAME: merge_vcf.sh
# DESCRIPTION: This script performs several steps:
#				1. Build a mash distance sketch based on input fasta files
#				2. Use the sketch to form a pairwise distance matrix
#				3. Create a scree plot of the matrix for analysis
#				4. Run a Pyseer MDS model using mash, ROARY output and traits
#				5. Run a Pyseer MDS model using VCFs
#				6. Create a QQ plot of the VCF SNP data
# 
# CONDA ENVIRONMENTS USED: pyseer_env
# TOOL DEPENDENCIES: pyseer, mash, bcftools, htslib
# 
# INPUTS (IN ORDER): 
#	+ vcf_file- the path to the VCF input file; if a directory, all VCFs will be merged
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
conda activate pyseer_env

vcf_file=$1

###################
#~- MAIN SCRIPT -~#
###################

# check if the VCF input is a file or a directory
[[ -d "$vcf_file" ]] && vcf_dir=1
[[ -f "$vcf_file" ]] && vcf_dir=0

# if VCF input is a directory, merge all VCFs
if [[ "$vcf_dir" -eq 1 ]]; then 
	for f in "$vcf_file"*.filt.vcf; do
		bgzip $f
		bcftools index $f.gz
	done
	
	bcftools merge --force-samples -m none -0 -O z -o "$vcf_file"merged.vcf.gz "$vcf_file"*.vcf.gz
	vcf_file="$vcf_file"merged.vcf.gz
fi