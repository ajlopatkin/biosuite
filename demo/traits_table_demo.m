% This demo generates a traits table from a metadata spreadsheet
% The first column in the traits table should *always* correspond 
% to the accession numbers you are working with, and the rest of the column
% should be the metadata categories you want to keep.
% In this example, we are clustering plasmids, so the
% first column is the plasmid accession number. Then, the categories are
% ST, epi_type, and Mobility.

clear, close all, clc

%% input
% define path to metadata and read in the table
BasePath = getenv("BIOSUITE_HOME");
input_data_file = BasePath + "/demo/demo_data/metadata.xlsx";
T = readtable(input_data_file);

%% determine and store new table of traits to keep
% define the column names to keep. These correspond exactly to the column
% names of the columns in our metadata. Loop through our table to find the
% column indices, and create a subset.
ColsToKeep = ["plasmidID_reduced","ST","epi_type","transferrability"];
ind = [];
for q = 1:length(ColsToKeep)
    ind(end+1) = find(strcmp(T.Properties.VariableNames,ColsToKeep(q)));
end
T_traits = T(:,ind);

%% output
% write new table as traits file
writetable(T_traits,BasePath+"/demo/output/traits.csv")