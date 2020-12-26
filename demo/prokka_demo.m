% % # INPUTS (IN ORDER): 
% % #	+ 1. prefix_name - file prefix (must be same file name as in input_fasta)
% % #	+ 2. input_fasta - Path for input file to be annotated
% % #	+ 3. output_dir - Directory path for storing output files
% % #	+ 4. genus - Organism genus: Enterococcus, Escherichia, or Staphylococcus

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Name of .fasta file (extracted from input file path)
prefix_name = "demo_genome";

%Input 2: Path of input .fasta file
input_fasta = BasePath + "/demo/demo_data/" + prefix_name + ".fasta";

%Input 3: Directory path for output 
output_dir = BasePath + "/demo/output/prokka/";

%Input 4: Organism genus
genus = "Escherichia"
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
% run prokka
prokka(input_fasta,output_dir,prefix_name,genus);
%%%%%%%%%%%%%%%%%%%%%%
