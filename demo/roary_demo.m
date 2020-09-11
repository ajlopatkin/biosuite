% % % # INPUTS (IN ORDER): 
% % % #	+ 1. path_to_gffs - input directory with all prokka .gff files
% % % #	+ 2. output_dir - output directory
% % % #	+ 3. min_blast_pct - minimum blast pct identity (default 95)
% % % # see http://sanger-pathogens.github.io/Roary/

BasePath = getenv("BIOSUITE_HOME");
path_to_gffs = BasePath + "/demo/demo_data/roary_demo/";
output_dir = BasePath + "/demo/output/roary/";
mkdir(output_dir)
min_blast_pct = 95;

roary(path_to_gffs,output_dir,min_blast_pct)
