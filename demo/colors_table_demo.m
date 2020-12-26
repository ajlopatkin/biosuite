% This demo converts an input traits table into a traits_color table, where
% each unique category from every trait is converted into a color for
% heatmap plotting
% % # INPUTS (IN ORDER): 
% % #	+ 1. input_file - file path to input metadata table  
% % #	+ 2. output_file - path for output .txt file
% % # COLOR CUSTOMIZATION: 
% % #	+ 1. colors1: define colors for category 1 (ex. Sequence Type)
% % #	+ 2. colors2: define colors for category 2, if applicable
% % #	+ 3. colors3: define colors for category 3, if applicable

clear;close all;clc

BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%%
%Input 1: define path to metadata and read in the table
input_data_file = BasePath + "/demo/demo_data/traits_demo.csv";

%Input 2: Path for output .txt file
output_file = BasePath + "/demo/output/traits_color.csv";
%%%%%%%%%%%%%%%%%%%%%%%%

%%% COLOR CUSTOMIZATION %%%
% Color options: https://python-graph-gallery.com/100-calling-a-color-with-seaborn/
% Clustergram options: https://medium.com/@morganjonesartist/color-guide-to-seaborn-palettes-da849406d44f

colors1 = {'blue' 'crimson' 'gold' 'mediumseagreen' 'blueviolet' 'black'...
    'darkgrey' 'greenyellow' 'mediumspringgreen' 'gold'};

colors2 = {'white' 'black'};

colors3 = {'red' 'yellow' 'blue'};
%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%% DEMO %%%%%%%%%%
%read in input table
T_traits = readtable(input_data_file);

% generate colors file from phenotype file
ST = categorical(string(T_traits.ST),string(unique(T_traits.ST)),...
    colors1(1:length(unique(T_traits.ST))));
Epi = categorical(string(T_traits.epi_type),string(unique(T_traits.epi_type)),...
    colors2(1:length(unique(T_traits.epi_type))));
Mobility = categorical(string(T_traits.transferrability),...
    string(unique(T_traits.transferrability)),...
    colors3(1:length(unique(T_traits.transferrability))));

T_traits.ST = ST;
T_traits.epi_type = Epi;
T_traits.transferrability = Mobility;

% store color output in new table
writetable(T_traits,output_file)
%%%%%%%%%%%%%%%%%%%%%%%%%%

