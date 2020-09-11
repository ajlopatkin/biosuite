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

BasePath = getenv("BIOSUITE_HOME");
input_dir = BasePath + "/demo/demo_data/roary_demo/input_gffs/";
output_dir = BasePath + "/demo/output/query_output/";
roary_files = BasePath + "/demo/output/roary/";
mkdir(output_dir);

query_flag = "d";
groups = roary_files + "clustered_proteins";
seq1 = input_dir + "prokka_CP020055.1.gff";
seq2 = input_dir + "prokka_CP020058.1.gff";
seq3 = input_dir + "prokka_CP020116.1.gff";

list1 = seq1;
list2 = seq2 + "," + seq3;

query_pan_genome(output_dir,query_flag,groups,list1,list2)