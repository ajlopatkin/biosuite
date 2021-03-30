% This demo aligns illumina fastq paired end reads to a reference file
% using BWA alignment

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. fwd_read - full path name of forward read
% % % #	+ 2. reference_file - path to reference file for alignment in .fasta, .fna, or .fa format
% % % #	+ 3. output_dir - path to existing folder where bwa results will be written
% % % #	+ 4. output_prefix - prefix name to label bam and sam files

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");
fwd_read = BasePath + "/demo/demo_data/KP28_S30_L001_R1_001.fastq.gz";
reference_file = BasePath + "/demo/demo_data/reference/GCF_002148835.1_ASM214883v1_genomic.fna";
output_prefix = "KP28";
output_dir = BasePath + "/demo/output/bowtie2" + output_prefix + "/";

bwa(fwd_read,reference_file,output_dir,output_prefix)
