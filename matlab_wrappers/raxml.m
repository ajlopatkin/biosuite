function raxml(input_file, output_dir, bootstrap_num, outgroup)

if nargin == 3
    
    str = "bash $BIOSUITE_HOME/bash_source/raxml.sh "...
        + input_file + " " + output_dir + " " + bootstrap_num + " " + outgroup;
    [status,cmdout] = system(str);
    if status ~= 0
        disp("Error running RaxML! Output below...")
        disp(cmdout)
    end
    
else

    str = "bash $BIOSUITE_HOME/bash_source/raxml.sh "...
        + input_file + " " + output_dir +  " " + bootstrap_num;
    [status,cmdout] = system(str);
    if status ~= 0
        disp("Error running RaxML! Output below...")
        disp(cmdout)
    end
    
end