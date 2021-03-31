% % % # INPUTS (IN ORDER): 
% % % #	+ 1. input_file - input directory containing prokka .gff files
% % % #	+ 2. ref_file - Path to directory to store roary output
% % % #	+ 3. output_dir - minimum blast pct identity (default 95)
% % % # + 4. prefix - name to append the SNIPPY output folder
% % % # + 5. core_flag - indciates running the core genome alignment
% % % # see https://github.com/tseemann/snippy

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Path to input directory of .fna file
input_file = BasePath + "/demo/demo_data/snippy_demo/SAMEA1709744.fna";

%Input 2: Path to reference sequence (.gb or .fasta)
ref_file = BasePath + "/demo/demo_data/snippy_demo/CP010781.gb";

%Input 3: Path to output directory 
output_dir = BasePath + "/demo/output/snippy/";

%Input 4: Folder prefix name
prefix = 'snippy_demo';
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir)
snippy(input_file,ref_file,output_dir,prefix)
%%%%%%%%%%%%%%%%%%%%%%
