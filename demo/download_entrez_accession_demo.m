% % % # INPUTS (IN ORDER): 
% % % #	+ 1. acc_id- the accession ID of the genome to be downloaded
% % % # + 2. format- the format of the downloaded file (fasta, genbank)
% % % #	+ 3. database - name of db to download from (nucleotide or protein likely)
% % % #	+ 4. outputdir - the output directory to store the file
clear; close all; clc

acc_id = "NC_002695.2";
format = "fasta";
database = "nucleotide";
BasePath = getenv("BIOSUITE_HOME");
outputdir = BasePath + "/demo/output";

download_entrez_accession(acc_id,format,database,outputdir)




