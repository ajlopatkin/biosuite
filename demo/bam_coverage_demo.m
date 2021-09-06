% This demo aligns illumina fastq paired end reads to a reference file
% using BWA alignment

% % % # INPUTS (IN ORDER): 
% % % #	+ 1. sorted_bam - full path name of sorted BAM file
% % % #	+ 2. output_dir -output directory

clear; close all; clc
BasePath = getenv("BIOSUITE_HOME");
sorted_bam = BasePath + "/demo/output/bwa2KP28_spades/KP28_spades_bwa.sorted.bam";
output_dir = BasePath + "/demo/output/bwa2KP28_spades/";
bam_coverage(sorted_bam,output_dir)
