% This script clusters and plots MASH distances 

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. mash_square_input- path + file name for mash distance matrix
% % % # + 2. color_file- color traits file
% % % # + 3. mash_cluster_output- folder + txt file name to store cluster
%            groups

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: File path for mash distance matrix file
mash_square_input = BasePath + "/demo/demo_data/mash_demo/mash.txt";

%Input 2: File path for color traits file
color_file = BasePath + "/demo/demo_data/mash_demo/traits_color_plasmid.csv";

%Input 3: Path for output .txt file
mash_cluster_output = BasePath + "/demo/output/mash_cluster_groups.txt";
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mash_cluster(mash_square_input,mash_cluster_output,color_file)
%%%%%%%%%%%%%%%%%%%%%%
