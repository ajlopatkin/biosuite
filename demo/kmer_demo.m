% This demo determine closest matched species with kmerfinder

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_fasta- input fasta file
% % % # + 2. outputpath- output folder

clear; close all; clc

file_name = "demo_genome";
BasePath = getenv("BIOSUITE_HOME");
input_fasta = BasePath + "/demo/demo_data/" + file_name + ".fasta";
outputpath = BasePath + "/demo/output/kmer/";
kmerfinder(input_fasta,outputpath)

str = "cp " + outputpath + "results.spa " + outputpath + "results.csv"; system(str);
% results can be found in outputpath + "results.csv"
