% This demo implements de novo genome alignment using Spades from paired end fastq files

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. fwd_read - forward trimmed read
% % % #	+ 2. rv_read - reverse trimmed read
% % % #	+ 3. output_dir - output directory
% % % #	+ 4. plasmid_flag - 1 or 0 for assembling a plasmid

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
fwd_read = BasePath + "/demo/demo_data/trimmomatic/KP28_S30_L001_R1_001.fastq.gz_trimmed_paired.fastq";
rv_read = BasePath + "/demo/demo_data/trimmomatic/KP28_S30_L001_R2_001.fastq.gz_trimmed_paired.fastq";
output_dir = BasePath + "/demo/output/spades/";
plasmid_flag = 0;
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
spades(fwd_read, rv_read, output_dir, plasmid_flag)
%%%%%%%%%%%%%%%%%%%%%%
