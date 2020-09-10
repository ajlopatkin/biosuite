function snippy(input_file,ref_file,output_dir,prefix)

str = "bash $BIOSUITE_HOME/bash_source/snippy.sh " +...
    input_file + " " + ref_file + " " + output_dir + " " + prefix;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Snippy! Output below...")
    disp(cmdout)
end
