#!/bin/bash

# SCRIPT NAME: pyseer.sh
# DESCRIPTION: This script performs several steps:
#				1. Build a mash distance sketch based on input fasta files
#				2. Use the sketch to form a pairwise distance matrix
#				3. Create a screen plot of the matrix for analysis
#				4. Run a Pyseer MDS model using mash, ROARY output and traits
#				5. Run a Pyseer MDS model using VCFs
#				6. Create a QQ plot of the VCF SNP data
# 
# CONDA ENVIRONMENTS USED: pyseer_env
# TOOL DEPENDENCIES: pyseer, mash, bcftools, htslib
# 
# INPUTS (IN ORDER): 
#	+ fasta_folder- the path to the directory containing input FASTAs
#	+ mash_output- the path to write the mash output file
#	+ traits_file- the oath to the the traits file 
#	+ gene_presence_file- the path to the ROARY output gene_presence_absence file
#	+ pyseer_cog_file- the path to write the pyseer COG output
#	+ vcf_file- the path to the VCF input file; if a directory, all VCFs will be merged
#	+ pyseer_snp_file- tge path to write the pyseer VCF output
#	+ mash_sketch_size- the max size of the mash sketch (default=10000)
#	+ num_cpus- number of CPUs to use for the Pyseer runs (default=1)
#	+ min_af- the lower MAF cutoff to use (default=0.02)
#	+ max_af- the upper MAF cutoff to use (default=0.98)
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

# Parse the inputs
fasta_folder=$1
mash_output=$2
traits_file=$3
gene_presence_file=$4
pyseer_cog_file=$5
vcf_file=$6
pyseer_snp_file=$7
mash_sketch_size=$8
num_cpus=$9
min_af=${10}
max_af=${11}
max_dim=${12}
sample_rehead_name=${13}

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

bcftools reheader --samples $sample_rehead_name -o "$vcf_file"_renamed $vcf_file
bgzip "$vcf_file"_renamed
vcf_file="$vcf_file"_renamed.gz

# run mash sketching and create scree plot
mash sketch -s "$mash_sketch_size" -o mash_sketch "$fasta_folder"*.fna
mash dist mash_sketch.msh mash_sketch.msh | square_mash > "$mash_output"
scree_plot_pyseer "$mash_output"

# run pyseer; first with mash distance, then with SNPs
pyseer --phenotypes "$traits_file" --print-samples --pres "$gene_presence_file" --distances "$mash_output"\
# --save-m mash_mds --max-dimensions "$max_dim" --cpu "$num_cpus" > "$pyseer_cog_file"
pyseer --phenotypes "$traits_file" --print-samples --vcf "$vcf_file"_renamed --min-af "$min_af" --max-af "$max_af"\
 --load-m mash_mds.pkl --cpu "$num_cpus" > "$pyseer_snp_file"
python $BIOSUITE_HOME/bash_source/qq_plot.py "$pyseer_snp_file"

# below creates a manhattan plot to use in Phandango
cat <(echo "#CHR SNP BP minLOG10(P) log10(p) r^2") \
<(paste <(sed '1d' "$pyseer_snp_file" | cut -d "_" -f 2) \
<(sed '1d' "$pyseer_snp_file" | cut -f 4) | \
awk '{p = -log($2)/log(10); print "26",".",$1,p,p,"0"}' ) | \
tr ' ' '\t' > "$pyseer_snp_file".plot
