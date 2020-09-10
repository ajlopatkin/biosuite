function raxml(input_file,output_dir)

str = "bash $BIOSUITE_HOME/bash_source/raxml.sh "...
    + input_file + " " + output_dir;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running RaxML! Output below...")
    disp(cmdout)
end