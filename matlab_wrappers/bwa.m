function bwa(fwd_read,reference_file,output_dir,output_prefix,PE_flag)

if ~isdir(output_dir)
    mkdir(output_dir)
end

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/bwa.sh " + fwd_read + " " + ...
    reference_file + " " + output_dir + " " + output_prefix + " " + PE_flag;

[status,cmdout] = system(str)

