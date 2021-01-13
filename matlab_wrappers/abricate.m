function abricate(input_file,output_folder,db_type)

str = "bash $BIOSUITE_HOME/bash_source/abricate.sh " +...
    input_file + " " + output_folder + " " + db_type;

[status,cmdout] = system(str)

if status ~= 0
    disp("Error running RGI! Output below...")
    disp(cmdout)
end