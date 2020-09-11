% % % # INPUTS (IN ORDER): 
% % % #	+ 1. acc_id - the accession ID of the genome to be downloaded
% % % # + 2. outputdir - 
clear; close all; clc

BasePath = getenv("BIOSUITE_HOME");
outputdir = BasePath + "/demo/output/fasta_downloads/";
mkdir(outputdir)
extension = "_genomic.fna.gz";
acc_id = "SAMN01911278";
download_entrez_biosample(acc_id,outputdir,extension)
