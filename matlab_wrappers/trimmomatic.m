function trimmomatic(fwd_read)

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/trimmomatic.sh " + fwd_read;

[status,cmdout] = system(str)

