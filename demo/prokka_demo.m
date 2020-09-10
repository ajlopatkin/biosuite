% % # INPUTS (IN ORDER): 
% % #	+ 1. input_fasta - input file to annotate
% % #	+ 2. output_dir - directory
% % #	+ 3. prefix_name - file prefix

clear;close all;clc

% run prokka
BasePath = getenv("BIOSUITE_HOME");
prefix_name = "demo_genome";
input_fasta = BasePath + "/demo/demo_data/" + prefix_name + ".fasta";
output_dir = BasePath + "/demo/output/prokka/";
mkdir(output_dir)
prokka(input_fasta,output_dir,prefix_name);

