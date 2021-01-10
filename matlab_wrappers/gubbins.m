function gubbins(multi_fasta_alignment)


str = "bash $BIOSUITE_HOME/bash_source/gubbins.sh " + multi_fasta_alignment;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Gubbins! Output below...")
    disp(cmdout)
end



