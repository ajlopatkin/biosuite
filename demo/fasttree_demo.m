% This demo builds a phylogenetic tree from an aligned input sequence file

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- input aligned file
% % % # + 2. output_tree- output newick tree

clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
file_name = "core_gene_alignment";
input_aln = BasePath + "/demo/demo_data/" + file_name + ".aln";
output_tree = BasePath + "/demo/output/" + file_name + ".newick";
fasttree(output_tree,input_aln)