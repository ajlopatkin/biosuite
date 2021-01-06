% This demo builds a phylogenetic tree from an aligned input sequence file

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- path for aligned sequence input file
% % % # + 2. output_tree- path for output newick tree

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
% Input 1: Path to input aligned file (.aln extension)
input_aln = BasePath + "/demo/demo_data/core_gene_alignment.aln";

%Input 2: Path for output file (.newick extension)
output_tree = BasePath + "/demo/output/core_gene_alignment.newick";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
fasttree(output_tree,input_aln)
%%%%%%%%%%%%%%%%%%%%%%
