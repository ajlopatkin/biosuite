% This script demonstrates using CARDS database to identify resistance genes
% from fasta file
% % # INPUTS (IN ORDER):
% % #	+ 1. fasta_file - path to input fasta file
% % #	+ 2. output_file - file for output data

clear;close all;clc
file_name = "demo_genome";
BasePath = getenv("BIOSUITE_HOME");
input_file = BasePath + "/demo/demo_data/" + file_name + ".fasta";
output_file = BasePath + "/demo/output/" + file_name + "_RGI";

rgi(input_file,output_file)
T = readtable('demo_genome_RGI.txt');
writetable(T,BasePath + "/demo/output/RGI.xlsx")