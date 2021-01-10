function download_entrez_biosample(acc_id,outputdir,extension)



if nargin == 3
    
    ind = [];
    count = 1;
    while isempty(ind)
        str = "bash $BIOSUITE_HOME/bash_source/download_entrez_biosample.sh "...
            + acc_id + " " + outputdir;
        [status,cmdout] = system(str);
        
        if status ~= 0
            disp("Error running Entrez! Output below...")
            disp(cmdout)
        end
        
        pause(1)
        s = dir(outputdir);
        ind = find(contains({s.name}','GCA'));
        
        
        if ~isempty(ind)
            
            for ii = 1:length(ind)
                file_to_move = s(ind(ii)).folder + "/" + s(ind(ii)).name + "/" + s(ind(ii)).name + extension;
                if ~isfile(file_to_move)
                    disp("File does not exist")
                else
                    movefile(file_to_move,outputdir + acc_id + ".fna.gz");
                end
                pause(1)
                rmdir(s(ind(ii)).folder + "/" + s(ind(ii)).name,'s')
            end
        end
        
        count = count + 1;
        if count > 5
            break
        end
        
    end
else
    
    
    str = "bash $BIOSUITE_HOME/bash_source/download_entrez_biosample.sh "...
        + acc_id + " " + outputdir;
    [status,cmdout] = system(str);
    
    if status ~= 0
        disp("Error running Entrez! Output below...")
        disp(cmdout)
    end
    
    
end