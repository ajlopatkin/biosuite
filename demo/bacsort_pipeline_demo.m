%% Pipeline for running bacsort
%%% Bacsort downloads genome assemblies from RefSeq, clusters them to
%%% account for mislabeling and redundancy, and constructs a phylogenetic
%%% tree of the clustered results. 

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. fasta_dir- input folder containing fastas in .fasta or .fna
%               format
% % % # + 2. bacsort_output- path where bacsort will write fasta files.
%            This cannot be inside of the folder specified for fasta_dir.



close all; clear all; clc

BasePath = getenv("BIOSUITE_HOME");

%%% USER INPUT %%%
%Input 1: Path to folder of input .fasta or .fna files
fasta_dir = BasePath + "/demo/demo_data/bacsort_demo/";

%Input 2: Path to folder for output fasta files.
bacsort_output = BasePath + "/demo/output/bacsort/";
%%%%%%%%%%%%%%%%%

%%%%%% DEMO %%%%%
% format fastas to get all to be .fna.gz
format_fastas(fasta_dir); pause(3)
% run BACSORT
bacsort(fasta_dir, bacsort_output, "mash_db_bacsort");
%%%%%%%%%%%%%%%%%





