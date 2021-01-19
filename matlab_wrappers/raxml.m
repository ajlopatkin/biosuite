function raxml(input_file, output_dir, bootstraps, outgroup)


if nargin == 3
    
    str = "bash $BIOSUITE_HOME/bash_source/raxml.sh "...
        + input_file + " " + output_dir + " " + bootstraps + " " + outgroup;
    [status,cmdout] = system(str);
    if status ~= 0
        disp("Error running RaxML! Output below...")
        disp(cmdout)
    end
    
else

    str = "bash $BIOSUITE_HOME/bash_source/raxml.sh "...
        + input_file + " " + output_dir +  " " + bootstraps;
    [status,cmdout] = system(str);
    if status ~= 0
        disp("Error running RaxML! Output below...")
        disp(cmdout)
    end
    
end