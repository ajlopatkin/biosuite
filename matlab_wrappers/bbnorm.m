function bbnorm(fwd_read,output_dir,read_depth)

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/bbnorm.sh " +...
    fwd_read + " " + output_dir + " " + read_depth;

[status,cmdout] = system(str)

