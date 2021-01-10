% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_dir - input directory containing prokka .gff files
% % % #	+ 2. ref_file - Path to directory to store roary output
% % % #	+ 3. output_dir - minimum blast pct identity (default 95)
% % % # see https://github.com/tseemann/snippy

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Path to input directory of .fna file
input_dir = BasePath + "/demo/demo_data/snippy_multi_demo/";

%Input 2: Path to reference sequence (.gb or .fasta)
ref_file = BasePath + "/demo/demo_data/snippy_multi_demo/CP010781.gb";

%Input 3: Path to output directory 
output_dir = BasePath + "/demo/output/snippy_multi/";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
snippy_multi(input_dir,ref_file,output_dir)
%%%%%%%%%%%%%%%%%%%%%%
