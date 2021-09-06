% This demo assigns the serotype of e coli strains

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_file - full path to fasta
% % % #	+ 2. output_folder - full path to tab-delimited clermont output

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
% Input 1: full path and file of input fasta
input_file = BasePath + "/demo/demo_data/demo_genome.fasta";

% Input 2: Full path to output file 
output_folder = BasePath + "/demo/output/ectyper/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
ectyper(input_file,output_folder)
%%%%%%%%%%%%%%%%%%%%%%
