% This demo builds a phylogenetic tree from multisequence alignment

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- input aligned file
% % % # + 2. output_dir- output newick tree
% % % # + 3. bootstrap_num- number of bootstrap repetitions
% % % # + 4. tree_model - model to use for tree (GTRGAMMA for nucleotide; PROTGAMMAAUTO for amino acid)
% % % # + 5. OPTIONAL: outgroup- accession ID of outgroup to root the tree

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
% Input 1: full path and file of multi-sequence alignment input
input_aln = BasePath + "/demo/demo_data/sampleAA_sucA.phy";

% Input 2: Full path to output directory (must be empty)
output_dir = BasePath + "/demo/output/raxml/";

% Input 3: Number of bootstrap repetitions
bootstrap_num = 100;

% Input 4: Tree model to use
tree_model = "PROTGAMMAAUTO"
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
raxml(input_aln,output_dir,bootstrap_num,tree_model)
%%%%%%%%%%%%%%%%%%%%%%
