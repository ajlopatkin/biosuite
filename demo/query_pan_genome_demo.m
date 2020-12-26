% % # INPUTS (IN ORDER): 
% % #	+ 1. output_dir - output directory; include file name for summary data
% % #	+ 2. query_flag - query action:
% % #	# # # u - union of all genes in isolates (pan genes)
% % #	# # # i - intersection of genes found in isolates (core genes)
% % #	# # # c - complement of genes found in isolates (accessory genes)
% % #	# # # m - creates multi-fasta of each gene listed
% % #	# # # d - difference between two sets of .gff genomes
% % #	+ 3. groups - clustered-Proteins groups file (roary output) 
% % #	+ 4. list1 
% % #	+ 5. list2 
% % #			- if query_flag is u, i, or c, then this list is all .gff
% % #				files of interest. No list2.
% % #		    - if query flag is m, then list 1 is a comma separated
% % #		    	list of genes, and list2 is all of the .gff files
% % #			- if query_flag is d, list1 is one set of .gff and list2 is the other

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%Input 1: Output directory path
output_dir = BasePath + "/demo/output/query_output/";

%Input 2: Query flag: 'u, 'i', 'c', 'm', or 'd'
query_flag = "d";

%Input 3: clustered-Proteins groups file
groups = BasePath + "/demo/output/roary/clustered_proteins";

%%% Input 4 and 5 - additional customization required below %%%

%Optional: path for directory holding gff files, if applicable
input_dir = BasePath + "/demo/demo_data/roary_demo/input_gffs/";

%Input 4 for query flag u, i, or c: 
%  List of all .gff files. Template below has slots for two files, add more
%  as needed by copying from the '+' to the end of the line and pasting in 
%  front of the semicolon
Input4_opt1 = "[path to 1st .gff file here]" + ", [second .gff file here]";

%Input 4 for query flag m: 
%  Comma separated list of genes. Template below has slots for 3 genes, add
%  more as needed. 
Input4_opt2 = "[gene1], [gene2], [gene3]";

%Input 4 for query flag d: 
%  One set of .gff files. Template below has slots for two files, add more
%  as needed by copying from the '+' to the end of the line and pasting in 
%  front of the semicolon
Input4_opt3 = "[path to 1st .gff file here]" + ", [second .gff file here]";

%Select correct option based on query flag, and assign to list1 below. 
%   u, i, or c: Input4_opt1
%            m: Input4_opt2, 
%            d: Input4_opt3
list1 = Input4_opt1;

%Input 5 for query flag u, i, c:
%   Leave blank. 
Input5_opt1 = "";

%Input 5 for query flag m:
%   List of all .gff files. Template below has slots for two files, add more
%   as needed by copying from the '+' to the end of the line and pasting in 
%   front of the semicolon
Input5_opt2 = "[path to 1st .gff file here]" + ", [second .gff file here]";

%Input 5 for query flag d:
%   Second list of .gff files. Template below has slots for two files, add more
%   as needed by copying from the '+' to the end of the line and pasting in 
%   front of the semicolon
%      Example: input_dir + "prokka_CP020058.1.gff" + "," + input_dir + "prokka_CP020116.1.gff";
Input5_opt3 = "[path to 1st .gff file here]" + ", [second .gff file here]";

%Select correct option based on query flag, and assign to list2 below.
%   u, i, or c: Input5_opt1
%            m: Input5_opt2, 
%            d: Input5_opt3
list2 = input5_opt1;
%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%% DEMO %%%%%%%%
mkdir(output_dir);
query_pan_genome(output_dir,query_flag,groups,list1,list2)
%%%%%%%%%%%%%%%%%%%%%%
