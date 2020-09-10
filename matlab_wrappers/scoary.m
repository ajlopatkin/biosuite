function scoary(gene_presence_absence_path,traits_path,output_dir)

str = "bash $BIOSUITE_HOME/bash_source/scoary.sh " +...
    gene_presence_absence_path + " " + traits_path + " " + output_dir;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running StarAMR! Output below...")
    disp(cmdout)
end