% % % # INPUTS (IN ORDER): 
% % % #	+ 1. path_to_gffs - input directory containing prokka .gff files
% % % #	+ 2. output_dir - Path to directory to store roary output
% % % #	+ 3. min_blast_pct - minimum blast pct identity (default 95)
% % % # see http://sanger-pathogens.github.io/Roary/
clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Path to input directory of .gff files
path_to_gffs = BasePath + "/demo/demo_data/roary_demo/";

%Input 2: Path to output directory 
output_dir = BasePath + "/demo/output/roary/";

%Input 3: Minimum blast pct identity
min_blast_pct = 95;
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
roary(path_to_gffs,output_dir,min_blast_pct)
%%%%%%%%%%%%%%%%%%%%%%
