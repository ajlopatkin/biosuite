% This demo builds a phylogenetic tree from multisequence alignment

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. output_file - output path and file name
% % % #	+ 2. input_file - input aligned fasta file

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
% Input 1: full path and file of multi-sequence alignment input
output_file = BasePath + "/demo/output/snpsites.txt";

% Input 2: Full path to output directory (must be empty)
input_file = BasePath + "/demo/demo_data/core.full.filtered_polymorphic_sites.fasta";
%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%% DEMO %%%%%%%%
snpsites(output_file,input_file)
%%%%%%%%%%%%%%%%%%%%%%
