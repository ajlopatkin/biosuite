% This script demonstrates using amrfinderplus to identify resistance genes
% from nucleotide data
% % # INPUTS (IN ORDER): 
% % #	+ 1. fasta_file - path to input fasta file
% % #	+ 2. db_flag - p or n
% % #	+ 3. output_file - file for output data
    
BasePath = getenv("BIOSUITE_HOME");
fasta_file = BasePath + "/demo/demo_data/demo_genome.fasta";
db_flag = 'n';
output_file = BasePath + "/demo/output/AMRfinderplus_demo.txt";

amrfinderplus(fasta_file,db_flag,output_file)