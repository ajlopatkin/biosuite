#!/bin/bash

# SCRIPT NAME: bowtie2.sh
# DESCRIPTION: Aligns fastq data to a reference file using the bowtie2 algorithm, and generates a sam, bam, and sorted bam for viewing
# 
# CONDA ENVIRONMENTS USED: bowtie2_env
# TOOL DEPENDENCIES: bowtie2_ and samtools
# 
# INPUTS (IN ORDER): 
#	+ 1. fwd_read - full path name of forward read
#	+ 2. reference_file - path to reference file for alignment in .fasta, .fna, or .fa format
#	+ 3. output_dir - path to existing folder where bowtie2 results will be written
#	+ 4. output_prefix - prefix name to label bam and sam files
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
conda activate bowtie2_env

# Parse the inputs
fwd_read=$1
reference_file=$2
output_dir=$3
output_prefix=$4

###################
#~- MAIN SCRIPT -~#
###################
forwardread=$(basename "$fwd_read")
reverseread=$(echo $forwardread | sed -e "s/_R1_/_R2_/g")
input_dir=$(dirname $fwd_read)/


bowtie2-build -f "$reference_file" "$output_prefix"_bowtie
bowtie2 -x "$output_prefix"_bowtie -1 "$input_dir""$forwardread" -2 "$input_dir""$reverseread" -S "$output_dir""$output_prefix"_bowtie.sam
samtools view -S -b "$output_dir""$output_prefix"_bowtie.sam > "$output_dir""$output_prefix"_bowtie.bam
samtools sort "$output_dir""$output_prefix"_bowtie.bam -o "$output_dir""$output_prefix"_bowtie.sorted.bam


