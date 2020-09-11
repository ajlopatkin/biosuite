%% Pipeline for clustering plasmids and visualizing clustergram + heatmap

%%% Independent project:
%%%     We are interested in characterizing the occurrence of metabolic
%%%     genes on plasmids in epidemic E. coli strains. We have curated the
%%%     dataset and now we need to look for trends amongst the plasmids. To
%%%     do this, we are going to cluster the plasmids based on their
%%%     nearest-neighbor sequence, and look for trends in the metadata.
%%%     Plasmid clusters with high metabolic gene content can be pulled
%%%     down and examined further.

%%%%%%%%%% 1. Download plasmid sequences from accession numbers
%%%%%%%%%% 2. Run mash to cluster them
%%%%%%%%%% 3. Run bacsort to identify redundant sequences
%%%%%%%%%% 4. Filter accessions and run mash again
%%%%%%%%%% 5. Create phenotype file from metadata
%%%%%%%%%% 6. Create colors file from phenotype file
%%%%%%%%%% 7. Plot in python

close all
clear all
clc

%% step 1
disp("Currently on step 1...")
% load in accession numbers from plasmid database
T = readtable("/demo_data/plasmid_sample.xlsx");
accessions = strip(T.PlasmidAccessionNum);
% define directory to store fasta files within your current directory
outputdir = "/Users/alopatki/Documents/MATLAB/BioSuite/demo/plasmid_mash";
mkdir(outputdir)
format = "fasta";
database = "nucleotide";
% loop through and download sequence files from NCBI
for q = 1:length(accessions)
    download_entrez(accessions{q},format,database,outputdir)
end
% format fastas to get all to be .fna.gz
format_fastas(outputdir);


%% step 2
disp("Currently on step 2...")
% run mash distances on downloaded genomes
input_folder = "/Users/alopatki/Documents/MATLAB/BioSuite/demo/plasmid_mash/";
output_file =  input_folder + "mash_distances";
db_name = "mashdb";
mash(output_file,input_folder,db_name)


%% step 3
disp("Currently on step 3...")
% % run BACSORT
mkdir("bacsort_run");
mkdir("bacsort_run/analysis/"); 
copyfile(input_folder, "bacsort_run/analysis/"); pause(2)
cd bacsort_run;
bacsort(input_folder + "bacsort_run"); pause(2)
cd ..


%% step 4
disp("Currently on step 4...")
% run mash distances on downloaded genomes
input_folder = "/Users/alopatki/Documents/MATLAB/BioSuite/demo/plasmid_mash/bacsort_run/";
output_file2 =  input_folder + "/mash_distances_2";
db_name = "mashdb";
mash(output_file2,input_folder,db_name)
% replace mash_t with list of files from plasmid_mash/bacsort_run
mash_T = mash2table(output_file2, true);
[h i] = intersect(T.plasmidID_reduced,mash_T.ref);
T = T(i,:);


%% step 5
disp("Currently on step 5...")
% generate phenotypes file
% shown below is an example for including ST, epi_type, and mobility as the phenotypes
% Always include plasmidID_reduced IDs as the first column
T_traits = table(T.plasmidID_reduced,T.ST,T.epi_type,T.transferrability,'VariableNames',{'plasmidID' 'ST' 'epi_type' 'Mobility'});
writetable(T_traits,outputdir+"/traits.csv")


%% step 6
disp("Currently on step 6...")
% generate colors file from phenotype file
% see link for color options: https://python-graph-gallery.com/100-calling-a-color-with-seaborn/
% mash_cluster.py clustergram options: https://medium.com/@morganjonesartist/color-guide-to-seaborn-palettes-da849406d44f
colors1 = {'blue' 'crimson' 'gold' 'mediumseagreen' 'blueviolet' 'black' 'darkgrey' 'greenyellow' 'mediumspringgreen' 'gold'};
colors2 = {'white' 'black'};
colors3 = {'red' 'yellow' 'blue'};
ST = categorical(string(T_traits.ST),string(unique(T_traits.ST)),colors1(1:length(unique(T_traits.ST))));
Epi = categorical(string(T_traits.epi_type),string(unique(T_traits.epi_type)),colors2(1:length(unique(T_traits.epi_type))));
Mobility = categorical(string(T_traits.Mobility),string(unique(T_traits.Mobility)),colors3(1:length(unique(T_traits.Mobility))));
T_traits.ST = ST;
T_traits.epi_type = Epi;
T_traits.Mobility = Mobility;
writetable(T_traits,outputdir+"/traits_color.csv")


%% step 7
disp("Currently on step 7...")
% define files
input_file = outputdir + "/mash_distances";
output_file = outputdir+"/mash_clust.txt";
color_file = outputdir+"/traits_color.csv";
% run mash
mash_square_output = input_folder + "mash_square.txt";
mash_cluster_output = input_folder + "mash_clusters.txt";
mash(mash_square_output,input_folder)
mash_cluster(mash_square_output,mash_cluster_output,color_file)


