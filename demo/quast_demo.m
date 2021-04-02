% This demo determine closest matched species with kmerfinder

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. fasta_scaffold - input file of fasta assembly
% % % #	+ 2. output_folder - new non-existent folder for data output
% http://quast.sourceforge.net/docs/manual.html

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Fasta_scaffold
fasta_scaffold = BasePath + "/demo/demo_data/scaffolds.fasta";

%Input 2: Output_folder
output_folder = BasePath + "/demo/output/quast/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
quast(fasta_scaffold,output_folder)
%%%%%%%%%%%%%%%%%%%%%%
