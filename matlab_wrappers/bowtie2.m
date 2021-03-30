function bowtie2(fwd_read,reference_file,output_dir,output_prefix)

if ~isdir(output_dir)
    mkdir(output_dir)
end

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/bowtie2.sh " + fwd_read + " " + ...
    reference_file + " " + output_dir + " " + output_prefix;

[status,cmdout] = system(str)

