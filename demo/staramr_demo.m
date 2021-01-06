% This script uses starAMR  to identify resistance genes from a 
% % # INPUTS (IN ORDER):
% % #	+ 1. input_file - path to input fasta file
% % #	+ 2. output_dir - Path to directory for output data- MUST NOT EXIST

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: path to input .fasta file
input_file = BasePath + "/demo/output/fasta_downloads/demo_genome.fna";

%Input 2: Path to directory to store output files
output_dir = BasePath + "/demo/output/demo_genome_staramr";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
staramr(output_dir,input_file)
%%%%%%%%%%%%%%%%%%%%%%
