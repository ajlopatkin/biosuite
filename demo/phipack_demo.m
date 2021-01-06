% This demo builds a phylogenetic tree from an aligned input sequence file
% Warning: Runtime can be long. 

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- Path for aligned input sequence file
% % % # + 2. output_file- Path for output phipack text file

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Path for aligned input sequence file
input_aln = BasePath + "/demo/demo_data/core_gene_alignment.aln";

%Input 2: Path for output phipack text file
output_file = BasePath + "/demo/output/core_gene_alignment_phipack.txt";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
phipack(input_aln,output_file)
%%%%%%%%%%%%%%%%%%%%%%

