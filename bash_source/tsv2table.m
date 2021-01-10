function tbl_out = tsv2table(tsv_file,header)
% tsv2table - create a table from a tab-separated file.
%   Use this function to create a table from a tsv (tab-separated) file.
%   The file can have any extension, but must have unix tabs (not spaces)
%   separating each column. If the file contains a header row, it will be
%   read automatically; if not, you can pass in the header. Data types will
%   be parsed as either numeric (double) or string by the script.
%
%   tbl = tsv2table(tsv_file) creates a MATLAB table from the file
%   tsv_file. The function will check that the file exists and can be read,
%   and then load it. The first line will be used as the header, and all
%   other lines will be included as table rows.
%
%   tbl = tsv2table(tsv_file, header) does the same as above, but uses the
%   header as provided by the user. This must be a cell array of the same
%   size as the data to be loaded.

    % check that input file is valid
    if ~isfile(tsv_file)
        error('Input TSV file does not exist.');
    end
    
    % check the input arguments- either 1 or 2
    if nargin == 1
        header = [];
    end
    
    % if header is provided, parse it and create the output table
    if isempty(header)
        header_loaded = false;
    else
        header_loaded = true;
        num_vars = length(header);
        var_type = cellstr(repmat("string",1,num_vars)); % initialize as strings
        tbl_out = table('Size',[0,num_vars],'VariableTypes',var_type,'VariableNames',header);
    end
    
    % open the file
    fid = fopen(tsv_file);
    
    while true
        
        % get current line; if it is not a char, we've hit the file end
        curr_line = fgetl(fid);
        if ~ischar(curr_line); break; end
        
        % split the current line by tabs
        line_split = split(curr_line, '	');
        
        % if the header was not provided, create it from the first line
        if ~header_loaded
            num_vars = length(line_split);
            var_type = cellstr(repmat("string",1,num_vars));
            tbl_out = table('Size',[0,num_vars],'VariableTypes',var_type,'VariableNames',line_split');
            header_loaded = true;
            continue
        else
            num_vars = length(line_split);
            if num_vars ~= width(tbl_out)
                error('Provided header is of different size than input TSV. Please check header.');
            end
        end
        
        % pass the current line into the table
        tbl_out(end+1, :) = line_split';
        
    end
    
    % close out the file
    fclose(fid);
    
    % recast numeric columns to double
    for k = 1:width(tbl_out)
        
        var_name = tbl_out.Properties.VariableNames{k};
        if ~any(isnan(double(tbl_out.(var_name))))
            recast_col = double(tbl_out.(var_name));
            tbl_out.(var_name) = recast_col;
        end
        
    end

end

