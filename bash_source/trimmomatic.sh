#!/bin/bash

# SCRIPT NAME: trimmomatic.sh
# DESCRIPTION: Trims adapaters from fastq files using default illumina sequences. Files
# automatically stored in fastq folder subdirectory
# 
# CONDA ENVIRONMENTS USED: qc_env
# TOOL DEPENDENCIES: trimmomatic
# 
# INPUTS (IN ORDER): 
#	+ 1. fwd_read - full path name of forward read
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
conda activate qc_env

# Parse the inputs
fwd_read=$1

###################
#~- MAIN SCRIPT -~#
###################

inputdir=$(dirname $fwd_read)/
mkdir "$inputdir"trimmomatic
adapterpath="$CONDA_BASE"/envs/qc_env/share/trimmomatic/adapters/

forwardread=$(basename "$fwd_read")
reverseread=$(echo $forwardread | sed -e "s/_R1_/_R2_/g")
forwardread_trimmed="$forwardread"_trimmed_paired.fastq
reverseread_trimmed="$reverseread"_trimmed_paired.fastq
forwardread_trimmed_unpaired="$forwardread"_trimmed_unpaired.fastq
reverseread_trimmed_unpaired="$reverseread"_trimmed_unpaired.fastq

trimmomatic PE "$inputdir$forwardread" "$inputdir$reverseread"\
 "$inputdir"trimmomatic/"$forwardread_trimmed"\
 "$inputdir"trimmomatic/"$forwardread_trimmed_unpaired"\
 "$inputdir"trimmomatic/"$reverseread_trimmed"\
 "$inputdir"trimmomatic/"$reverseread_trimmed_unpaired"\
 ILLUMINACLIP:"$adapterpath"TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
