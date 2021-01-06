% % % This demo will download a BioSample from NCBI using Entrez Direct
% % % BioSamples: https://www.ncbi.nlm.nih.gov/biosample/ 

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. acc_id - the BioSample accession ID of the genome to be downloaded
% % % # + 2. outputdir - the path of the output directory to store the file 

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");

%%%% USER INPUT %%%%
%Input 1: Biosample accession ID
acc_id = "SAMN01911278";

%Input 2: Path to output folder in which to place downloaded .fasta file
outputdir = BasePath + "/demo/output/fasta_downloads/";
%%%%%%%%%%%%%%%%%%%%

%%%%%%% DEMO %%%%%%%
mkdir(outputdir)
extension = "_genomic.fna.gz";
download_entrez_biosample(acc_id,outputdir,extension)
%%%%%%%%%%%%%%%%%%%%
