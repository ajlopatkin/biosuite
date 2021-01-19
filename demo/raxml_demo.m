% This demo builds a phylogenetic tree from multisequence alignment

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- input aligned file
% % % # + 2. output_dir- output newick tree
% % % # + 3. bootstraps- number of bootstrap repetitions
% % % # + 4. OPTIONAL: outgroup- accession ID of outgroup to root the tree

clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
file_name = "sampleAA_sucA";
input_aln = BasePath + "/demo/demo_data/" + file_name + ".phy";
output_dir = BasePath + "/demo/output/raxml/";
mkdir(output_dir)
bootstraps = 100; 
raxml(input_aln,output_dir,bootstraps)
