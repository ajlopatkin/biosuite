% create conda environments
clc
disp("This script will install the selected BioSuite conda environments.")
disp(" ");disp("Checking available disk space...")

FileObj = java.io.File("/");
usable_gb = FileObj.getUsableSpace/1e9;

if usable_gb > 50
    disp("Found >50GB free disk space available.")
else
    disp("<50GB disk space available; installing all conda environments will take ~50GB disk space. Consider freeing up some disk space before continuing.")
    keep_going = input("Continue with install? [y/n] ",'s');
    if ismember(lower(keep_going),["y","yes"])
        disp("Continuing with install.")
    else
        disp("Exiting...")
        return
    end
end

conda_envs = dir("conda_envs");
disp(" ");all_envs = input("Install all remaining envs? [y/n] ", 's');

if ismember(lower(all_envs),["y","yes"])
    disp(" ");disp("Creating conda environments. This may take some time...")
else
    disp(" ");disp("Will perform selective Conda installation. Note: for future installation of skipped environments, run conda_env_installer.m")
end

for k = 1:length(conda_envs)
    if ~contains(conda_envs(k).name, ".yml")
        continue
    end
    
    if ismember(lower(all_envs),["y","yes"])
        disp("Creating "+conda_envs(k).name + "...")
    else
        do_env = input("Install Conda env "+conda_envs(k).name+"? [y/n] ", 's');
        if ismember(lower(do_env),["y","yes"])
            disp("Creating "+conda_envs(k).name + "...")
        elseif ismember(lower(do_env),["n","no"])
            disp("Skipping "+conda_envs(k).name + "...")
            continue
        else
            disp("Unrecognized input. Skipping" +conda_envs(k).name + "...")
            continue
        end
    end
    
    str = "conda env create -f conda_envs/"+conda_envs(k).name;
    [stat, results] = system(str);
    if contains(results, "prefix already exists")
        disp("Environment already exists. Continuing.")
    elseif stat ~= 0
        disp("Environment creation had non-zero exit status for "+conda_envs(k).name+". Details:")
        disp(out)
    else
        disp("Successfully created "+conda_envs(k).name)
    end
end

disp("All requested conda environments created.")
