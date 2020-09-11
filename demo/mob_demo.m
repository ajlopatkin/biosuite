% This determines mobility group of plasmid sequence
% % # INPUTS (IN ORDER): 
% % #	+ 1. input_file - path to input fasta file
% % #	+ 2. output_dir - output directory
% % #	+ 3. flag - 't' for typer and 'r' for recon

clear;close all;clc
file_name = "demo_plasmid";
BasePath = getenv("BIOSUITE_HOME");
input_file = BasePath + "/demo/demo_data/" + file_name + ".fasta";
output_dir = BasePath + "/demo/output/";
flag = 't';
mob(input_file,output_dir,flag)