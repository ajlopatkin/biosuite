%This demo runs kaptive on an input fasta file(s), and outputs best locus
%match

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_fasta- input fasta file. Can use *.fna for multiple files
% % % # + 2. database- path to database file for K or OC locuses (.gbk)
% % % # + 3. output_dir- path for output files in format /file_path/prefix

clear; close all; clc 
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Input fasta file(s) path
input_dir = BasePath + "/demo/demo_data/kaptive_trial/*.fna";

%Input 2: Path to database file
database = BasePath + "/databases/kaptive_reference_databases/Acinetobacter_baumannii_k_locus_primary_reference.gbk";

%Input 3: Path to output directory (path/prefix)
output_dir = BasePath + "/demo/output/kaptive_demo/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
kaptive(input_dir, database, output_dir)
%%%%%%%%%%%%%%%%%%%%%%
