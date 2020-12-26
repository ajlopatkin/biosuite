function roary(path_to_gffs,output_dir,min_blast_pct)

input_dir = path_to_gffs + "/input_gffs/";
mkdir(input_dir)
system("cp " + path_to_gffs + "*.gff " + input_dir)

str = "bash $BIOSUITE_HOME/bash_source/roary.sh " +...
    input_dir + " " + output_dir + " " + min_blast_pct;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Roary! Output below...")
    disp(cmdout)
end
