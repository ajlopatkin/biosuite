% This script demonstrates using the CARDS database to identify resistance 
% genes from fasta file
% % # INPUTS (IN ORDER):
% % #	+ 1. fasta_file - path to input fasta file
% % #	+ 2. output_file - path to store output data
% % #	+ 3. excel_output - path to store output data in excel form

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: path to input .fasta file
input_file = BasePath + "/demo/demo_data/demo_genome.fasta";

%Input 2: Path to store RGI direct output 
output_file = BasePath + "/demo/output/demo_genome_RGI";

%Input 3: Excel output file path 
excel_output = BasePath + "/demo/output/RGI.xlsx";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
rgi(input_file,output_file)
T = readtable(output_file);
writetable(T,excel_output)
%%%%%%%%%%%%%%%%%%%%%%
