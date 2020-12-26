% This demo determines the closest matched species for a genome using
% kmerfinder. A numeric Sequence Type is included in the output. 

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_fasta- File path for input genome fasta file
% % % # + 2. output_path- Path for folder to hold output files

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1:File path for input genome fasta file
input_fasta = BasePath + "/demo/demo_data/demo_genome.fasta";

%Input 2: Path for folder to hold output files (can be nonexistent)
output_path = BasePath + "/demo/output/mlst/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_path)
mlst(input_fasta,output_path)
output_path = BasePath + "/demo/output/mlst/";
%%%%%%%%%%%%%%%%%%%%%%
