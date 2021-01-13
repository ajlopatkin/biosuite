% This script demonstrates using abricate to identify resistance genes
% from fasta file
% % # INPUTS (IN ORDER):
% % #	+ 1. input_file - path to input fasta file
% % #	+ 2. output_folder - folder 
% % #	+ 3. db_type - database options:
% % % argannot       
% % % card           
% % % ecoh          
% % % ecoli_vf       
% % % megares        
% % % ncbi           
% % % plasmidfinder  
% % % resfinder      
% % % vfdb           

% SOURCE: https://github.com/tseemann/abricate


clear;close all;clc
file_name = "demo_genome";
BasePath = getenv("BIOSUITE_HOME");
input_file = BasePath + "/demo/demo_data/" + file_name + ".fasta";
output_folder = BasePath + "/demo/output/";
db = "card";

abricate(input_file,output_folder,db)
