% % % This program downloads a genome from NCBI using Entrez Direct and the
% genome's accession ID, and places the download in a local FASTA file

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. acc_id- the accession ID of the genome to be downloaded
% % % # + 2. format- either "fasta" or "genbank"
% % % #	+ 3. database - name of database to download genome from
% % % #	+ 4. outputdir - path for the output 

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%% USER INPUT %%%%
%Input 1: Accession ID of genome
acc_id = "SAMN02604038";

%Input 2: Format for downloaded file: "fasta" or "genbank"
format = "fasta";

%Input 3: Database to download from (example: "nucleotide" or "protein")
database = "nucleotide";

%Input 4: path for output directory
outputdir = BasePath + "/demo/output";
%%%%%%%%%%%%%%%%%%%%

%%%%%%% DEMO %%%%%%%
download_entrez_accession(acc_id,format,database,outputdir)
%%%%%%%%%%%%%%%%%%%%


