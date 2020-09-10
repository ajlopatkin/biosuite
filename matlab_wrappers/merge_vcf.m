function merge_vcf(vcf_file)

% note: all genome/sample names must match between the traits, Roary Rtab,
%       and fasta files. You won't get any sample hits otherwise.
%
% inputs:
%   -fasta_dir: the directory containing the fasta files to process
%   -mash_output: the path to write the mash matrix output file
%   -traits_file: the path to the traits/phenotypes input file
%   -gene_presence_file: the path to the ROARY gene input Rtab file
%   -pyseer_cog_output: the path to write the non-SNP pyseer output
%   -vcf_file: the path to a merged VCF file or a directory of unmerged VCF
%   -pyseer_snp_output: the path to write the SNP pyseer output

    % parse varargin for option arguments; these are:
    %   1. mash_sketch_size- the max size of the mash sketch (default=10000)
    %   2. num_cpus- number of CPUs to use for the Pyseer runs (default=1)
    %   3. min_af- the lower MAF cutoff to use (default=0.02)
    %   4. max_af- the upper MAF cutoff to use (default=0.98)
    %   5. max_dim- the number of dimensions to use for MDS (default=10)
   
    
    str = "bash $BIOSUITE_HOME/bash_source/merge_vcf.sh " + vcf_file;
    
    [status,cmdout] = system(str);
    
    if status ~= 0
        disp("Error while merging VCFs! Output below:");
        disp(cmdout)
    end

end

