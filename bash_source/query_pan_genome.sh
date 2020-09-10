#!/bin/bash

# SCRIPT NAME: query_pan_genome.sh
# DESCRIPTION: Queries output from roary for sets of genes
# 
# CONDA ENVIRONMENTS USED: roary_env
# TOOL DEPENDENCIES: roary
# 
# INPUTS (IN ORDER): 
#	+ 1. output_dir - output directory; include file name for summary data
#	+ 2. query_flag - query action:
#	# # # u - union of all genes in isolates (pan genes)
#	# # # i - intersection of genes found in isolates (core genes)
#	# # # c - complement of genes found in isolates (accessory genes)
#	# # # m - creates multi-fasta of each gene listed
#	# # # d - difference between two sets of .gff genomes
#	+ 3. groups - clustered-Proteins groups file (roary output) 
#	+ 4. list1 
#	+ 5. list2 
#			- if query_flag is u, i, or c, then this list is all .gff
#				files of interest. No list2.
#		    - if query flag is m, then list 1 is a comma separated
#		    	list of genes, and list2 is all of the .gff files
#			- if query_flag is d, list1 is one set of .gff and list2 is the other
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
output_dir="$1"
query_flag="$2"
groups="$3"
list1="$4"
list2="$5"

###################
#~- MAIN SCRIPT -~#
###################

if [[ $query_flag == u ]]; then
	query_pan_genome -g "$groups" -a union "${@:4}"
    mv pan_genome_results $output_dir
elif [[ $query_flag == i ]]; then
	query_pan_genome -g "$groups" -a intersection "${@:4}"
    #mv pan_genome_results $output_dir
elif [[ $query_flag == c ]]; then
	query_pan_genome -g "$groups" -a complement "${@:4}"
    mv pan_genome_results $output_dir
elif [[ $query_flag == m ]]; then
	query_pan_genome -g "$groups" -a gene_multifasta -n "$list1" "${@:5}"
    mv pan_genome_results_* $output_dir
elif [[ $query_flag == d ]]; then
	query_pan_genome -g "$groups" -a difference --input_set_one "$list1" --input_set_two "$list2"
    mv set_difference* $output_dir
fi

echo $output_dir
