% This script calculates MASH distances for input fasta files.
% Output of this program can be used as input for mash_cluster_demo.m

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_folder- folder containing all fasta files to use
% % % # + 2. db_name- mash database name
% % % # + 3. output_folder- directory path to store MASH output
% % % # + 4. output_file- File name for mash distance matrix file (.txt)

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: File path for folder containing fasta files
input_folder = BasePath + "/demo/demo_data/bacsort_demo/";

%Input 2: Name of MASH database
db_name = "mash_db_demo";

%Input 3: Output directory path. Must not end with "/"
output_folder = BasePath + "/demo/output/mash";

%Input 4: Output file name. Must start with "/", must end with ".txt"
output_file = "/mash.txt";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_folder)
full_output = output_folder + output_file;
mash_square(full_output,input_folder,db_name)
%%%%%%%%%%%%%%%%%%%%%%
