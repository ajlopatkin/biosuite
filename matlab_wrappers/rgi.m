function rgi(input_file,output_file)

str = "bash $BIOSUITE_HOME/bash_source/rgi.sh " +...
    input_file + " " + output_file;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running RGI! Output below...")
    disp(cmdout)
end