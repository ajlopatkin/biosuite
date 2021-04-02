#!/bin/bash

# SCRIPT NAME: phaster.sh
# DESCRIPTION: Identifies phage MGE regions from single or multi-fasta file
# 
# CONDA ENVIRONMENTS USED: phaster_env
# TOOL DEPENDENCIES: wget
# 
# INPUTS (IN ORDER): 
#	+ 1. fasta_file - full path name of fasta file
#	+ 2. contigs_flag - flag to indicate fasta file consists of multi-fasta format of contigs
#	+ 3. output_file - path to output file
# 
# DATE UPDATED: 3/27/21
# AUTHOR: Allison Lopatkin

#########################
#~- ENVIRONMENT SETUP -~#
#########################


# Get the Conda source path
CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh
conda activate phaster_env

# Parse the inputs
fasta_file=$1
contigs_flag=$2
output_file=$3

###################
#~- MAIN SCRIPT -~#
###################
output_dir=$(dirname $output_file)/
wget --post-file="$fasta_file" "http://phaster.ca/phaster_api?contigs=$contigs_flag" -O "$output_dir"tmp.txt
content=$(cat "$output_dir"tmp.txt)
jobID=$(grep -oP '(?<=job_id":").*?(?=",")' <<< "$content")
wget "http://phaster.ca/phaster_api?acc=$jobID" -O "$output_file"

while :
do
	if head -n 1 "$output_file" | grep -q "Complete"; then break; fi
	wget "http://phaster.ca/phaster_api?acc=$jobID" -O "$output_file"
	sleep 5
done
rm "$output_dir"tmp.txt

