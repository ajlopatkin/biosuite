% This demo determines the closest matched species for a genome using
% kmerfinder. A numeric Sequence Type is included in the output. 

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_fasta- File path for input genome fasta file
% % % # + 2. output_path- Path for folder to hold output files
% % % # + 3. database- Species database for MLST prediction 

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1:File path for input genome fasta file
input_fasta = BasePath + "/demo/demo_data/demo_genome.fasta";

%Input 2: Path for folder to hold output files (can be nonexistent)
output_path = BasePath + "/demo/output/mlst/";

%Input 3: Species database (see docs for full list of options)
database = "ecoli";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_path)
mlst(input_fasta,output_path)
output_path = BasePath + "/demo/output/mlst/";
%%%%%%%%%%%%%%%%%%%%%%
