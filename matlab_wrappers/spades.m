function spades(fwd_read, rv_read, output_dir, plasmid_flag)

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/spades.sh " + fwd_read + " " + ...
    rv_read + " " + output_dir + " " + plasmid_flag;

[status,cmdout] = system(str)

