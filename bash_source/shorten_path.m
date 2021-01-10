function short_path = shorten_path(full_path)
% shorten_path.m - take a fully qualified file path and shorten it to a
% relative path, based on the current working directory. This should be
% used only when full paths result in errors such as exceeding MAX_ARGS in
% the bash environment.

    current_path = pwd;
    
    % validate input path
    if ~isfolder(full_path) && ~isfile(full_path)
        error("Input path could not be validated; please check that it exists and is a valid file or directory.")
    end
    
    % split paths
    curr_path_split = split(current_path, "/");
    full_path_split = split(full_path, "/");
    
    % get path lengths
    curr_path_len = length(curr_path_split);
    full_path_len = length(full_path_split);
    min_len = min(curr_path_len,full_path_len);
    
    % get path elements common to both directories
    common_path = strcmp(curr_path_split(1:min_len), full_path_split(1:min_len));
    common_path_len = sum(common_path);
    
    % form the short path
    if curr_path_len == common_path_len % full path is inside current dir
        prefix = "./";
        suffix = strjoin(full_path_split(common_path_len+1:end),"/");
        short_path = prefix + suffix;
    else
        prefix = strjoin(repelem("..",curr_path_len - common_path_len),"/") + "/";
        suffix = strjoin(full_path_split(common_path_len+1:end),"/");
        short_path = prefix + suffix;
    end
    
    % if input is a directory, add trailing slash
    if isfolder(full_path)
        short_path = short_path + "/";
    end
    
    % test short path to make sure it is valid
    if ~isfolder(short_path) && ~isfile(short_path)
        error("Path creation failed; generated path is " + short_path)
    elseif ~all(ls(short_path) == ls(full_path))
        warning("Generated path may not be consistent; please validate.")
    end
    
end