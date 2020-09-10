function kmerfinder(input_fasta,outputpath)

str = "bash $BIOSUITE_HOME/bash_source/kmerfinder.sh " + input_fasta + " " + outputpath;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running KmerFinder! Output below...")
    disp(cmdout)
end
