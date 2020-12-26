% This demo generates a traits table from a metadata spreadsheet
% The first column in the traits table should *always* correspond 
% to the accession numbers you are working with, and the rest of the column
% should be the metadata categories you want to keep.
% In this example, we are clustering plasmids, so the
% first column is the plasmid accession number. Then, the categories are
% ST, epi_type, and Mobility.

% % # INPUTS (IN ORDER):
% % #	+ 1. input_file - path to input metadata file
% % #	+ 2. ColsToKeep - List of column names from metadata to keep in 
% % #         traits table
% % #	+ 3. output_file - path for output file to store traits table

clear, close all, clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: path to input metadata file
input_data_file = BasePath + "/demo/demo_data/metadata.xlsx";

%Input 2: Column names to keep
ColsToKeep = ["plasmidID_reduced","ST","epi_type","transferrability"];

%Input 3: Path for output file to store traits table
output_file = BasePath+"/demo/output/traits.csv"
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
% read in the table from metadata
T = readtable(input_data_file);

%% determine and store new table of traits to keep
% define the column names to keep. Loop through table to find the
% column indices, and create a subset.
ind = [];
for q = 1:length(ColsToKeep)
    ind(end+1) = find(strcmp(T.Properties.VariableNames,ColsToKeep(q)));
end
T_traits = T(:,ind);

% write new table as traits file
writetable(T_traits,output_file)
%%%%%%%%%%%%%%%%%%%%%%
