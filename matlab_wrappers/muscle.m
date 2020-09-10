function muscle(input_file,output_file)

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/muscle.sh " + input_file + " " + output_file;

[status,cmdout] = system(str);



