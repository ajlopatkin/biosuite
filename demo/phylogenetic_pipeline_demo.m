% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_dir_single - input directory single end read files
% % % #	+ 2. input_dir_paired - input directory of paired read files
% % % #	+ 3. ref_file - Path to reference sequence file
% % % #	+ 4. output_dir - Path to output directory for final tree files
% % % # see https://github.com/tseemann/snippy

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Path to input directory of single read .fna files
input_dir_single = BasePath + "/demo/phylo_pipe_2/input/Single/";

%Input 2: Path to input directory of paired read .fna files
input_dir_paired = BasePath + "/demo/phylo_pipe_2/input/Pairs/";

%Input 3: Path to reference sequence (.gb or .fasta)
ref_file = BasePath + "/demo/phylo_pipe_2/input/CP010781.gb";

%Input 4: Path to output directory 
output_dir = BasePath + "/demo/phylo_pipe_2/output/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
phylo_pipeline(input_dir_single, input_dir_paired,ref_file,output_dir)
%%%%%%%%%%%%%%%%%%%%%%
