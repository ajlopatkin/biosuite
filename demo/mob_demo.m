% This determines mobility group of plasmid sequence using MOB
% % # INPUTS (IN ORDER): 
% % #	+ 1. input_file - path to input .fasta file
% % #	+ 2. output_dir - Path output directory
% % #	+ 3. flag - 't' for replicon typing and 'r' for reconstruction

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: path to input .fasta file
input_file = BasePath + "/demo/demo_data/demo_plasmid.fasta";

%Input 2: path to output directory 
output_dir = BasePath + "/demo/output/";

%Input 3: MOB flag
flag = 't';
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mob(input_file,output_dir,flag)
%%%%%%%%%%%%%%%%%%%%%%
