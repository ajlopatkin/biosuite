% This script calculates MASH distances for input fasta files

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. output_file- path+file name for mash distance matrix
% % % # + 2. input_folder- folder containing all fasta files to use
% % % # + 3. db_name- mash database name

clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
input_folder = BasePath + "/demo/demo_data/bacsort_demo/";
output_folder = BasePath + "/demo/output/mash";
mkdir(output_folder)
output_file = output_folder + "/mash.txt";
db_name = "mash_db_demo";

mash_square(output_file,input_folder,db_name)