% This demo converts an input traits table into a traits_color table, where
% each unique category from every trait is converted into a color for
% heatmpa plotting

clear, close all, clc

%% input
% define path to metadata and read in the table
BasePath = getenv("BIOSUITE_HOME");
input_data_file = BasePath + "/demo/demo_data/traits_demo.csv";
T_traits = readtable(input_data_file);

%% define colors for each category
% generate colors file from phenotype file
% see link for color options: https://python-graph-gallery.com/100-calling-a-color-with-seaborn/
% mash_cluster.py clustergram options: https://medium.com/@morganjonesartist/color-guide-to-seaborn-palettes-da849406d44f
colors1 = {'blue' 'crimson' 'gold' 'mediumseagreen' 'blueviolet' 'black'...
    'darkgrey' 'greenyellow' 'mediumspringgreen' 'gold'};
colors2 = {'white' 'black'};
colors3 = {'red' 'yellow' 'blue'};

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

%% store in new table
writetable(T_traits,BasePath+"/demo/output/traits_color.csv")
