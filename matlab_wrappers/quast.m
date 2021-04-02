function quast(fasta_scaffold,output_folder)

str = "bash $BIOSUITE_HOME/bash_source/quast.sh " + fasta_scaffold + " " + output_folder;

[status,cmdout] = system(str);
if status ~= 0
    disp("Error running Quast! Output below...")
    disp(cmdout)
end


