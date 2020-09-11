% This demo runs enrichment analysis on an input set of genes

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_file- input aligned file
% % % # + 2. output_dir- output newick tree
% % % # + 3. db_type- KEGG, GO, or GO_BP

clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
input_file = "genescf_demo.txt";
output_dir = BasePath + "/demo/output/genescf_output/";
mkdir(output_dir)
str = "cp " + BasePath + "/demo/demo_data/" + input_file + " " + output_dir; system(str)
db_type = "KEGG";

genescf(input_file,output_dir,db_type)