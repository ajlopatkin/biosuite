%%Resistance Gene Consensus Search Pipeline

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");
id_list =["Ex003", "Ax270"];
base_folder = BasePath + "/demo/ab2/";
mkdir(base_folder)
consensus_folder = base_folder + "consensi/";
species = "a";
mkdir(consensus_folder)
i = 1;
while i <= length(id_list)
    id = id_list(i);
    disp(id)
    %Make id Folder
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