function raxml(input_file, output_dir, bootstrap_num, tree_model, outgroup)


if nargin == 5
    
    str = "bash $BIOSUITE_HOME/bash_source/raxml.sh "...
        + input_file + " " + output_dir + " " + bootstrap_num + " " + tree_model + " " + outgroup;
    [status,cmdout] = system(str);
    if status ~= 0
        disp("Error running RaxML! Output below...")
        disp(cmdout)
    end
    
else

    str = "bash $BIOSUITE_HOME/bash_source/raxml.sh "...
        + input_file + " " + output_dir +  " " + tree_model + " " + bootstrap_num;
    [status,cmdout] = system(str);
    if status ~= 0
        disp("Error running RaxML! Output below...")
        disp(cmdout)
    end
    
end
