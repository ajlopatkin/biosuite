% This demo runs enrichment analysis on an input set of genes

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_file- path for input file
% % % # + 2. output_dir- path for output directory
% % % # + 3. db_type- Database, either KEGG, GO, or GO_BP

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Input file path
input_file = "genescf_demo.txt";

%Input 2: Output directory path 
output_dir = BasePath + "/demo/output/genescf_output/";

%Input 3: Database 
db_type = "KEGG";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
str = "cp " + BasePath + "/demo/demo_data/" + input_file + " " + output_dir; system(str)
genescf(input_file,output_dir,db_type)
%%%%%%%%%%%%%%%%%%%%%%
