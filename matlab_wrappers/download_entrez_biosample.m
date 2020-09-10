function download_entrez_biosample(acc_id,outputdir,extension)

str = "bash $BIOSUITE_HOME/bash_source/download_entrez_biosample.sh "...
    + acc_id + " " + outputdir;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Entrez! Output below...")
    disp(cmdout)
end


s = dir(outputdir);
ind = find(contains({s.name}','GCA'));
file_to_move = s(ind).folder + "/" + s(ind).name + "/" + s(ind).name + extension;
if ~isfile(file_to_move)
    disp("File does not exist")
else
    movefile(file_to_move,outputdir + acc_id + ".fna.gz");
end

pause(1)
rmdir(s(ind).folder + "/" + s(ind).name,'s')