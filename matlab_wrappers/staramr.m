function staramr(output_dir,input_dir)

str = "bash $BIOSUITE_HOME/bash_source/staramr.sh " + output_dir + " " + input_dir;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running StarAMR! Output below...")
    disp(cmdout)
end
