% This demo builds a phylogenetic tree from an aligned input sequence file

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- input aligned file
% % % # + 2. output_file- output phipack text file

clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
file_name = "core_gene_alignment";
input_aln = BasePath + "/demo/demo_data/" + file_name + ".aln";
output_file = BasePath + "/demo/output/" + file_name + "_phipack.txt";
phipack(input_aln,output_file)



