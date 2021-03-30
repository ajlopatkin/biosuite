#!/bin/bash

# SCRIPT NAME: bwa.sh
# DESCRIPTION: Aligns fastq data to a reference file using the BWA toolkit, and generates a sam, bam, and sorted bam for viewing
# 
# CONDA ENVIRONMENTS USED: samtools_env
# TOOL DEPENDENCIES: bwa and samtools
# 
# INPUTS (IN ORDER): 
#	+ 1. fwd_read - full path name of forward read
#	+ 2. reference_file - path to reference file for alignment in .fasta, .fna, or .fa format
#	+ 3. output_dir - path to existing folder where bwa results will be written
#	+ 4. output_prefix - prefix name to label bam and sam files
#	+ 5. PE_flag - flag for aligning using paired end illumina reads
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
conda activate samtools_env

# Parse the inputs
fwd_read=$1
reference_file=$2
output_dir=$3
output_prefix=$4
PE_flag=$5

###################
#~- MAIN SCRIPT -~#
###################

forwardread=$(basename "$fwd_read")
input_dir=$(dirname $fwd_read)/
#bwa index "$reference_file"
#bwa aln "$reference_file" "$input_dir""$forwardread" > "$output_dir""$forwardread"_1.sai

if [[ $PE_flag -eq 1 ]]; then
	reverseread=$(echo $forwardread | sed -e "s/_R1_/_R2_/g")
	bwa aln "$reference_file" "$input_dir""$reverseread" > "$output_dir""$reverseread"_2.sai
	bwa sampe "$reference_file"  "$output_dir""$forwardread"_1.sai "$output_dir""$reverseread"_2.sai "$input_dir""$forwardread" "$input_dir""$reverseread" > "$output_dir""$output_prefix"_bwa.sam
else
    bwa mem "$reference_file" "$output_dir""$forwardread"_1.sai "$input_dir""$forwardread" > "$output_dir""$output_prefix"_bwa.sam
fi

samtools view -S -b "$output_dir""$output_prefix"_bwa.sam > "$output_dir""$output_prefix"_bwa.bam
samtools sort "$output_dir""$output_prefix"_bwa.bam -o "$output_dir""$output_prefix"_bwa.sorted.bam

#samtools mpileup -uf "$reference_file" "$output_dir""$output_prefix"_bwa.sorted.bam | bcftools call -c | vcfutils.pl vcf2fq > "$output_dir""$output_prefix"_bwa.fastq
#seqtk seq -aQ64 -q20 -n N "$output_dir""$output_prefix"_bwa.fastq > "$output_dir""$output_prefix"_bwa.fasta
