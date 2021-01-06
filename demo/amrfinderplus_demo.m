% This script demonstrates using amrfinderplus to identify resistance genes
% from nucleotide data
% % # INPUTS (IN ORDER): 
% % #	+ 1. fasta_file - path to input fasta file
% % #	+ 2. db_flag - 'p' for protein, or 'n' for nucleotide
% % #	+ 3. output_file - path for output data file (must be .txt)
% % #	+ 4. organism - Taxon for point mutation screening. Find options at:
% % #.       https://github.com/ncbi/amr/wiki/Running-AMRFinderPlus#--organism-option
clear;close all;clc 
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Path to input fasta file
fasta_file = BasePath + "/demo/output/fasta_downloads/SAMD00056130.fna";

%Input 2: Database flag
db_flag = 'n';

%Input 3: Path to output file
output_file = BasePath + "/demo/output/AMRfinderplus_SAMD00056130.txt";

%Input 4: Taxon
organism = "Escherichia"
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
%Run amrfinderplus
amrfinderplus(fasta_file,db_flag,output_file,organism)
%%%%%%%%%%%%%%%%%%%%%%
