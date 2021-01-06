% This demo determine closest matched species with kmerfinder

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_fasta- path for input fasta file
% % % # + 2. output_path- output folder

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Input fasta file path
input_fasta = BasePath + "/demo/output/fasta_downloads/SAMD00060955.fna";

%Input 2: Output direcotry path
output_path = BasePath + "/demo/output/SAMD00060955_genes/kmer/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
kmerfinder(input_fasta,outputpath)
str = "cp " + output_path + "results.spa " + output_path + "results.csv"; system(str);
% results can be found in output_path + "results.csv"
%%%%%%%%%%%%%%%%%%%%%%
