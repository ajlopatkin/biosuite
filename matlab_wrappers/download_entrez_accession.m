function download_entrez_accession(acc_ids,format,database,outputdir,extension)

if nargin == 4
    extension = format;
end

if ~iscell(acc_ids)
    acc_ids = cellstr(acc_ids);
end

for q = 1:length(acc_ids)
    acc_id = acc_ids{q};
    
    genome_file = outputdir + "/" + acc_id + "." + extension;
    if isfile(genome_file)
        continue
    end
    
    str = "bash $BIOSUITE_HOME/bash_source/download_entrez.sh "...
        + acc_id + " " + format + " "...
        + database + " " + outputdir + " " + extension;
    [status,cmdout] = system(str);
    if status ~= 0
        disp("Error running Entrez! Output below...")
        disp(cmdout)
    end
    
end
