% This demo builds a phylogenetic tree from multisequence alignment

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- Path for aligned input file 
% % % # + 2. output_dir- Path for directory to store output newick file

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: path to aligned input file
input_aln = BasePath + "/demo/demo_data/sampleAA_sucA.phy";

%Input 2: Directory path for output files
output_dir = BasePath + "/demo/output/raxml/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
raxml(input_aln,output_dir)
%%%%%%%%%%%%%%%%%%%%%%
