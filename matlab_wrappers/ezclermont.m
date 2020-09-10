function ezclermont(input_file,output_file)

str = "bash $BIOSUITE_HOME/bash_source/ezclermont.sh " + input_file + " " + output_file;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running EZClermont! Output below...")
    disp(cmdout)
end

