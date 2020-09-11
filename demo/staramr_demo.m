% This script demonstrates using starAMR  to identify resistance genes
% from fasta file
% % # INPUTS (IN ORDER):
% % #	+ 1. input_file - path to input fasta file
% % #	+ 2. output_dir - file for output data

clear;close all;clc
file_name = "demo_genome";
BasePath = getenv("BIOSUITE_HOME");
input_file = BasePath + "/demo/demo_data/" + file_name + ".fasta";
output_dir = BasePath + "/demo/output/" + file_name + "_staramr";
staramr(output_dir,input_file)
