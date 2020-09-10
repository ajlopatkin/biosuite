function genescf(input_file,output_dir,db_type)

% run the docker container hosting GeneSCF to annotate a gene list
% inputs:
%   -input_file: the *name* of the input file containing one gene per line
%                note that this file must exist in the output directory
%   -output_dir: the directory to write outputs into; MUST contain the input
%                file!
%   -db_type: either KEGG or GO_all (could be others as installed in
%             Docker container)

% Database to use as a source for finding gene enrichment, the options are 
% either geneontology 'GO_all' or geneontology-biological_process 'GO_BP' 
% or geneontology-molecular_function 'GO_MF' or geneontology-cellular_components 
% 'GO_CC' or kegg 'KEGG' or reactome 'REACTOME' or Network of Cancer
% Genes 'NCG' (Without quotes).

str = "bash $BIOSUITE_HOME/bash_source/genescf.sh " + input_file + " "...
     + output_dir + " " + db_type;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running GeneSCF! Output below...")
    disp(cmdout)
end
