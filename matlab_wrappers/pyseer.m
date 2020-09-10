function pyseer(fasta_dir, mash_output, traits_file, gene_presence_file,...
    pyseer_cog_output, vcf_file, pyseer_snp_output, sample_header_names, varargin)

% note: all genome/sample names must match between the traits, Roary Rtab,
%       and fasta files. You won't get any sample hits otherwise.
%
% inputs:
%   -fasta_dir: the directory containing the fasta files to process
%   -mash_output: the path to write the mash matrix output file name
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
    num_args = length(varargin);
    
    switch num_args
        case 0
            disp("No optional parameters provided; using defaults")
            mash_sketch_size = 10000;
            num_cpus = 1;
            min_af = 0.02;
            max_af = 0.98;
            max_dim=10;
        case 1
            mash_sketch_size = varargin{1};
            num_cpus = 1;
            min_af = 0.02;
            max_af = 0.98;
            max_dim = 10;
        case 2
            mash_sketch_size = varargin{1};
            num_cpus = varargin{2};
            min_af = 0.02;
            max_af = 0.98;
            max_dim = 10;
        case 3
            mash_sketch_size = varargin{1};
            num_cpus = varargin{2};
            min_af = varargin{3};
            max_af = 0.98;
            max_dim = 10;
        case num_args == 4
            mash_sketch_size = varargin{1};
            num_cpus = varargin{2};
            min_af = varargin{3};
            max_af = varargin{4};
            max_dim = 10;
        case 5
            mash_sketch_size = varargin{1};
            num_cpus = varargin{2};
            min_af = varargin{3};
            max_af = varargin{4};
            max_dim = varargin{5};
        otherwise
            disp("Incorrect number of optional arguments; using defaults")
            mash_sketch_size = 10000;
            num_cpus = 1;
            min_af = 0.02;
            max_af = 0.98;
            max_dim = 10;
    end
    
    str = "bash $BIOSUITE_HOME/bash_source/pyseer.sh " + fasta_dir + " "...
        + mash_output + " " + traits_file + " " + gene_presence_file + " "...
        + pyseer_cog_output + " " + vcf_file + " " + pyseer_snp_output + " "...
        + mash_sketch_size + " " + num_cpus + " " + min_af + " "...
        + max_af + " " + max_dim + " " + sample_header_names;
    
    [status,cmdout] = system(str);
    
    if status ~= 0
        disp("Error while running Pyseer! Output below:");
        disp(cmdout)
    end

end