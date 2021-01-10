% This demo determine closest matched species with kmerfinder

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. outout_dir - output directory that will be created
% % % #	+ 2. multi_fasta_align - input directory and file for multi-fasta aligned

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Output directory
output_dir = BasePath + "/demo/output/gubbins/";

%Input 2: Input core alignment
multi_fasta_align = BasePath + "/demo/demo_data/core.full.aln";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
gubbins(output_dir,multi_fasta_align)
%%%%%%%%%%%%%%%%%%%%%%
