function mash_square(output_file,input_folder,db_name)

% mash square: makes a square distance matrix where each row and column are
% the pairwise distances between two sequences

str = "bash $BIOSUITE_HOME/bash_source/mash_square.sh "...
    + output_file + " " + input_folder + " " + db_name;
[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Mash! Output below...")
    disp(cmdout)
end