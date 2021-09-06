function ectyper(input_file,output_folder)

str = "bash $BIOSUITE_HOME/bash_source/ectyper.sh " + input_file + " " + output_folder;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running ECTyper! Output below...");
    disp(cmdout)
end

