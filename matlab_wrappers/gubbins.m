function gubbins(multi_fasta_alignment, directory)


str = "bash $BIOSUITE_HOME/bash_source/gubbins.sh " + multi_fasta_alignment + " " + directory;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Gubbins! Output below...")
    disp(cmdout)
end