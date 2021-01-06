function muscle(input_file,output_file)

str = "bash $BIOSUITE_HOME/bash_source/muscle.sh " + input_file + " " + output_file;

[status,cmdout] = system(str);



