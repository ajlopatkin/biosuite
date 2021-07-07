function trimal(input_aln,output_aln,method, format)

str = "bash $BIOSUITE_HOME/bash_source/trimal.sh " +...
    input_aln + " " + output_aln + " " + method + " " + format;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running trimal! Output below...")
    disp(cmdout)
end
