% This determines the phylogroup of E coli strain using ezclermont typing scheme
% % # INPUTS (IN ORDER): 
% % #	+ 1. input_file - path to input fasta file
% % #	+ 2. output_file - text file for output data

clear;close all;clc
file_name = "demo_genome";
BasePath = getenv("BIOSUITE_HOME");
input_file = BasePath + "/demo/demo_data/" + file_name + ".fasta";
output_file = BasePath + "/demo/output/" + file_name + "_clermont.txt";

ezclermont(input_file,output_file)
