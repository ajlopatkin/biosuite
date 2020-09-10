function mash_table = mash2table(input_file, full_paths)
    
    % turn a non-square mash output into a table.
    %
    % if full_paths=true, the query/reference values are full paths and
    % will be clipped to accession numbers only.

    header = {'ref', 'query', 'mash_dist', 'pval', 'matched_hash'};
    
    mash_table = cell2table(cell(0,5),'VariableNames',header);
    
    fid = fopen(input_file);
    
    if nargin == 1
        full_paths = false;
    end
    
    while true
        
        line = fgetl(fid);
        
        if ~ischar(line)
            break
        end
        
        line_split = split(line, "	");
        
        if full_paths
            ref = split(line_split(1), "/");
            ref = split(ref(end),".");
            ref = ref(1);
            query = split(line_split(2), "/");
            query = split(query(end), ".");
            query = query(1);
            mash_table = [mash_table;{ref, query, line_split(3),...
                line_split(4), line_split(5)}];
        else
            mash_table = [mash_table;{line_split(1), line_split(2), line_split(3), ...
                line_split(4), line_split(5)}];
        end
        
    end
    
    mash_table.ref = string(mash_table.ref);
    mash_table.query = string(mash_table.query);
    mash_table.mash_dist = cellfun(@str2double, mash_table.mash_dist);
    mash_table.pval = cellfun(@str2double, mash_table.pval);
    mash_table.matched_hash = string(mash_table.matched_hash);
    
    fclose(fid)
    