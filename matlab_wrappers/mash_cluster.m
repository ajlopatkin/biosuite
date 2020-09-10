function mash_cluster(input_file,output_file,color_file)

str = "bash $BIOSUITE_HOME/bash_source/mash_cluster.sh "...
    + input_file + " " + output_file + " " + color_file;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Mash Cluster! Output below...")
    disp(cmdout)
end