% This script demonstrates using amrfinderplus to identify resistance genes
% from nucleotide data
% % # INPUTS (IN ORDER): 
% % #	+ 1. fasta_file - path to input fasta file
% % #	+ 2. db_flag - 'p' for protein, or 'n' for nucleotide
% % #	+ 3. output_file - path for output data file (must be .txt)
    
BasePath = getenv("BIOSUITE_HOME");

%Input 1: Path to input fasta file
fasta_file = BasePath + "/demo/output/fasta_downloads/SAMD00056130.fna";

%Input 2: Database flag
db_flag = 'n';

%Input 3: Path to output file
output_file = BasePath + "/demo/output/AMRfinderplus_SAMD00056130.txt";

%Run amrfinderplus
amrfinderplus(fasta_file,db_flag,output_file)
