% This demo trims ire1 multisequence alignment output (from muscle)

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_aln- input alignment file
% % % # + 2. output_aln- output alignment file
% % % # + 3. method- method to trim alignment (gappyout, strict, nogaps, etc.)
% % % #	+ 4. output format - phylip, fasta, clustal

clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
file_name = "trimal_demo";
input_aln = BasePath + "/demo/demo_data/trimal_demo.phy";
output_aln = BasePath + "/demo/output/" + file_name + "trimmed.phyl";
format = "phylip";
method = "gappyout";
trimal(input_aln,output_aln,method,format)