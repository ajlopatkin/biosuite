%% Pipeline for running bacsort

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. fasta_dir- input folder containing fastas in .fasta or .fna
%               format
% % % # + 2. bacsort_output- path where bacsort will write fasta files.
%            This cannot be inside of the same folder that the 
%            fastas were downloaded in to.



close all; clear all; clc


% define directory to store fasta files
BasePath = getenv("BIOSUITE_HOME");
fasta_dir = BasePath + "/demo/demo_data/bacsort_demo/";

% format fastas to get all to be .fna.gz
format_fastas(fasta_dir); pause(3)

% run BACSORT
bacsort_output = BasePath + "/demo/output/bacsort/";
bacsort(fasta_dir, bacsort_output, "mash_db_bacsort");





