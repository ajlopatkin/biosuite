#!/bin/bash

# SCRIPT NAME: blast_search.sh
# DESCRIPTION: Creates a local blast database given a multi fasta file input
# 
# CONDA ENVIRONMENTS USED: blast_env
# TOOL DEPENDENCIES: blast
# 
# INPUTS (IN ORDER): 
#	+ 1. query_file - query fasta file to search
#	+ 2. input_blast_db - makeblstdb output file
#	+ 3. output_blast - blast output results file name and path
#	+ 4. output_fasta - output file name and path
#	+ 5. db_flag - protein or nucleotide blast option "p" or "n"
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
conda activate blast_env

# Parse the inputs
query_file=$1
input_blast_db=$2
output_blast=$3
output_fasta=$4
db_flag=$5

###################
#~- MAIN SCRIPT -~#
###################

if [[ $db_flag == n ]]; then
	echo "Using blastn..."
	blastn -query "$query_file"	-db "$input_blast_db" -outfmt 7 -evalue 1e-4\
	 -out "$output_blast" -qcov_hsp_perc 50 -reward 2 -penalty -3 -word_size 11 -gapopen 5 -gapextend 2
	sed '/^#/ d' < "$output_blast" > "$output_blast"_parsed
else
	echo "Using blastp..."
	blastp -query "$query_file"	-db "$input_blast_db" -outfmt 7 -evalue 1e-4\
	 -out "$output_blast" -qcov_hsp_perc 50 -reward 2 -penalty -3 -word_size 11 -gapopen 5 -gapextend 2
	sed '/^#/ d' < "$output_blast" > "$output_blast"_parsed
fi

while read line; do
	start=$(echo "$line" | cut -d$'\t' -f9)
	stop=$(echo "$line" | cut -d$'\t' -f10)
	contig=$(echo "$line" | cut -d$'\t' -f2)

	if [[ "$stop" -gt "$start" ]]; then
        blastdbcmd -db "$input_blast_db" -entry all -range "$start"-"$stop" -out "$output_fasta"
        sed -i.bk 's/[])([]/_/g' "$output_fasta"
        full_contig=$(cat "$output_fasta" | grep "$contig")
        full_contig=${full_contig#?};
        echo $full_contig | awk '{gsub("_","\\_",$0);$0="(?s)^>"$0".*?(?=\\n(\\z|>))"}1' | pcregrep -oM -f - "$output_fasta" > "$output_fasta"_"$contig"_filtered
        rm "$output_fasta"
        rm "$output_fasta".bk
    else
        blastdbcmd -db "$input_blast_db" -entry all -range "$stop"-"$start" -out "$output_fasta"_nonrev
        sed -i.bk 's/[])([]/_/g' "$output_fasta"_nonrev
        full_contig=$(cat "$output_fasta"_nonrev | grep "$contig")
        full_contig=${full_contig#?};
        echo $full_contig | awk '{gsub("_","\\_",$0);$0="(?s)^>"$0".*?(?=\\n(\\z|>))"}1' | pcregrep -oM -f - "$output_fasta"_nonrev\
         | fasta_formatter | fastx_reverse_complement -o "$output_fasta"_"$contig"_filtered
        rm "$output_fasta"_nonrev
        rm "$output_fasta"_nonrev.bk
	fi
done<"$output_blast"_parsed



