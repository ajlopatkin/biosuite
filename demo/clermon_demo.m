% Determines the phylogroup of an E coli strain using the ezclermont
% typing scheme. 
% % # INPUTS (IN ORDER): 
% % #	+ 1. input_file - path to input fasta file
% % #	+ 2. output_file - text file for output data

clear;close all;clc

BasePath = getenv("BIOSUITE_HOME");

%%%% USER INPUT %%%%
%Input 1: Path to input fasta file
input_file = BasePath + "/demo/output/fasta_downloads/SAMN02603727.fna";

%Input 2: path to .txt file to store output data 
output_file = BasePath + "/demo/output/SAMN02603727_genes/clermont.txt";
%%%%%%%%%%%%%%%%%%%

%%%%%%% DEMO %%%%%%
ezclermont(input_file,output_file)
%%%%%%%%%%%%%%%%%%%
