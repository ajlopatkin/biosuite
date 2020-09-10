function mash_single(output_file,input_folder,db_name)

% mash single: column 1 and column 2 are the pair, and the remaining
% columns include distance and p-value

str = "bash $BIOSUITE_HOME/bash_source/mash_single.sh "...
    + output_file + " " + input_folder + " " + db_name;
[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Mash! Output below...")
    disp(cmdout)
end