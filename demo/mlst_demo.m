% This demo determine closest matched species with kmerfinder

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_fasta- input fasta file
% % % # + 2. output_path- output folder

clear; close all; clc

file_name = "demo_genome";
BasePath = getenv("BIOSUITE_HOME");
input_fasta = BasePath + "/demo/demo_data/" + file_name + ".fasta";
output_path = BasePath + "/demo/output/mlst/";
mkdir(output_path)
mlst(input_fasta,output_path)
