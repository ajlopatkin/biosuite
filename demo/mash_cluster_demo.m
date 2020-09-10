% This script clusters and plots MASH distances 

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. mash_square_input- path + file name for mash distance matrix
% % % # + 2. mash_cluster_output- folder + txt file name to store cluster
%           groups
% % % # + 3. color_file- color traits file

clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
mash_square_input = BasePath + "/demo/demo_data/mash_demo/mash.txt";
mash_cluster_output = BasePath + "/demo/output/mash_cluster_groups.txt";
color_file = BasePath + "/demo/demo_data/mash_demo/traits_color_plasmid.csv";
mash_cluster(mash_square_input,mash_cluster_output,color_file)
