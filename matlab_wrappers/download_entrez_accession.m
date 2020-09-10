function download_entrez_accession(acc_id,format,database,outputdir)

str = "bash $BIOSUITE_HOME/bash_source/download_entrez.sh "...
    + acc_id + " " + format + " "...
    + database + " " + outputdir;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Entrez! Output below...")
    disp(cmdout)
end

