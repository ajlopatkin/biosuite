function snpsites(output_file,input_file)

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/snpsites.sh " + output_file + " " + input_file;

[status,cmdout] = system(str)



