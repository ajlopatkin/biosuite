% % % # INPUTS (IN ORDER): 
% Roary
% % % #	+ 1. prefix_name - file prefix (must be same file name as in input_fasta)
% % % #	+ 2. input_fasta - Path for input file to be annotated
% % % #	+ 3. output_dir - Directory path for storing output files
% % % #	+ 4. genus - Organism genus: Enterococcus, Escherichia, or Staphylococcus
% Prokka
% % % #	+ 5. path_to_gffs - input directory containing prokka .gff files
% % % #	+ 6. output_dir - Path to directory to store roary output
% % % #	+ 7. min_blast_pct - minimum blast pct identity (default 95)
% % % # see http://sanger-pathogens.github.io/Roary/

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Name of scaffold.fasta file (extracted from input file path)
prefix_name = "demo_genome";

%Input 2: Path of input .fasta file
input_fasta = BasePath + "/demo/demo_data/" + prefix_name + ".fasta";

%Input 3: Directory path for output 
prokka_out = BasePath + "/demo/output/prokka/";

%Input 4: Organism genus
genus = "Escherichia";

%Input 5: Path to input directory of .gff files
path_to_gffs = BasePath + "/demo/output/prokka/";

%Input 6: Path to output directory 
output_dir = BasePath + "/demo/output/roary/";

%Input 7: Minimum blast pct identity
min_blast_pct = 95;
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(prokka_out);
mkdir(output_dir);
% run prokka
prokka(input_fasta,prokka_out,prefix_name,genus);
% run roary
roary(path_to_gffs,output_dir,min_blast_pct)
%%%%%%%%%%%%%%%%%%%%%%
