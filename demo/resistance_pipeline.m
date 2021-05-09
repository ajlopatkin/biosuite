%%Resistance Gene Search Pipeline
% % % # INPUTS (IN ORDER): 
% % % #	+ 1. id_list: List of biosample ids to run through the pipeline
% % % #	+ 2. base_folder: Path to directory to read/save intermediate and final pipeline outputs

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

% % Input 1: List of biosample/accession IDs
id_list =["Ex003", "Ax270"];

% % Input 2: Directory to hold outputs and folders created at each pipeline step
base_folder = BasePath + "/demo/ab2/";

% % Input 3: Species flag. a: Acinetobacter, 
species = "a";

%%%%%%%%%%%% PIPELINE %%%%%%%%%%
mkdir(base_folder)
consensus_folder = base_folder + "consensus/";
mkdir(consensus_folder)
i = 1;
while i <= length(id_list)
    id = id_list(i);
    disp(id)
    %Make ID Folder
    id_folder = base_folder + id + "/";
    mkdir(base_folder + id);
    %Download
    download_entrez_biosample(id,id_folder,"_genomic.fna.gz")
    %Find genes
    abricate(id_folder + id + ".fastq", id_folder, "card")
    abricate(id_folder + id + ".fastq", id_folder, "ncbi")
    abricate(id_folder + id + ".fastq",id_folder, "resfinder")
    %Merge
    merge_abricate_ARGs(id_folder, consensus_folder + id + ".csv")
 
    i = i + 1;
end
str = "bash $BIOSUITE_HOME/bash_source/resistance_pipeline.sh " + consensus_folder + " " + base_folder +" " + species;
 
 [status,cmdout] = system(str);
 disp(cmdout)
 if status ~= 0
     disp("Error running pipeline! Output below...")
     disp(cmdout)
 end
 
%%%%%%%%%% END PIPELINE %%%%%%%%%%
