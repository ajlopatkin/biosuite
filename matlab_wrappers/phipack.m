function phipack(multi_fasta_align,output_file)

str = "bash $BIOSUITE_HOME/bash_source/phipack.sh " +...
    multi_fasta_align + " " + output_file;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Phi! Output below...")
    disp(cmdout)
end