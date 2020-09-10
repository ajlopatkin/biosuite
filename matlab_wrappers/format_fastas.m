function format_fastas(fasta_dir)

    % convert all fastas in a folder to a common format:
    %   - rename the extension to .fna
    %   - compress using gzip

    % get all files/dirs in the folder
    s = dir(fasta_dir);
    
    % loop through all files/dirs
    for k = 1:length(s)
        
        % get the current file/dir
        filename = s(k).name;
        
        % check if the file is a fasta
        if contains(filename, ["fna","fasta","fa"])
            
            % if it is a fasta, check if it is gzipped
            if contains(filename, "gz")
                
                % just need to rename the extention to .fna
                if contains(filename, "fasta")
                    new_filename = strrep(filename, "fasta", "fna");
                elseif contains(filename, "fa")
                    new_filename = strrep(filename, "fa", "fna");
                else
                    continue
                end
                
                if strcmp(filename, new_filename)
                    continue
                end
                
                movefile(fullfile(s(k).folder,filename), fullfile(s(k).folder,new_filename));
                
            else
                % gzip and rename the extention to .fna
                gzip(fullfile(s(k).folder, filename));
                
                if contains(filename, "fasta")
                    new_filename = strrep(filename, "fasta", "fna") + ".gz";
                elseif contains(filename, "fa")
                    new_filename = strrep(filename, "fa", "fna") + ".gz";
                else
                    continue
                end
                
                if strcmp(filename+".gz", new_filename)
                    continue
                end
                
                movefile(fullfile(s(k).folder,filename) + ".gz", fullfile(s(k).folder,new_filename));
            end
            
        end
        
    end
    
    % delete the original uncompressed fastas
    str = "rm " + fasta_dir + " *.fna *.fasta *.fa";
    % system(str);