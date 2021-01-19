% This demo builds a phylogenetic tree from multisequence alignment

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- input aligned file
% % % # + 2. output_dir- output newick tree
% % % # + 3. bootstraps- number of bootstrap repetitions
% % % # + 4. OPTIONAL: outgroup- accession ID of outgroup to root the tree

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
% Input 1: Name of alignment including the absolute path
input_aln = BasePath + "/demo/demo_data/sampleAA_sucA.phy";

% Input 2: Path to output directory. This must be a new folder name that does not exist
output_dir = BasePath + "/demo/output/raxml/";

% Input 3: Number of bootstrap repetitions
bootstraps = 100; 

% Input 4: Optional outgroup accession ID
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
% run raxml
raxml(input_aln,output_dir,bootstraps)
%%%%%%%%%%%%%%%%%%%%%%

BasePath = getenv("BIOSUITE_HOME");
file_name = "sampleAA_sucA";
input_aln = BasePath + "/demo/demo_data/" + file_name + ".phy";
output_dir = BasePath + "/demo/output/raxml/";
mkdir(output_dir)
bootstraps = 100; 
raxml(input_aln,output_dir,bootstraps)
