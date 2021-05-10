function kaptive(input_dir, database, output_dir)
str = "bash $BIOSUITE_HOME/bash_source/kaptive.sh " + input_dir + " " + database + " " + output_dir;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Kaptive! Output below...")
    disp(cmdout)
end