%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIOSUITE INSTALLER V0.1
%
% Last Build: 8/24/20
%
% This installer performs basic setup of the BioSuite environment,
% including setting MATLAB path and environment variables, installing the
% necessary conda environments, and check that the necessary databases
% exist. It will also perform basic sanity checking of various installed
% tools.
%
% This installer requires that Anaconda is already installed; please see
% the Anaconda website at https://www.anaconda.com/products/individual if
% you need to install it. No additional packages are required before
% installing BioSuite; the conda environments included in
% conda_environments include installations of required python packages.
%
% For issues, please contact the Lopatkin Lab at www.lopatkinlab.com.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
disp("Welcome to BioSuite!")
disp("This script will install the MATLAB tools and configure your environment for use.")
disp(" ");disp("Checking available disk space...")

FileObj = java.io.File("/");
usable_gb = FileObj.getUsableSpace/1e9;

if usable_bytes > 150
    disp("Found >150GB free disk space available.")
elseif usable_bytes > 50
    disp("Found 50-150GB available; partial install recommended.")
else
    disp("<50GB disk space available; the full install of BioSuite will take ~100GB disk space. Consider freeing up some disk space before continuing.")
    keep_going = input("Continue with install? [y/n] ",'s');
    if ismember(lower(keep_going),["y","yes"])
        disp("Conintuing with install.")
    else
        disp("Exiting...")
        return
    end
end

disp(" ");disp("Checking current folder structure...")

% check the current directory for biosuite contents
if isfolder("databases") && isfolder("conda_environments")...
        && isfolder("bash_source") && isfolder("matlab_wrappers")
    disp("Directory structure OK.")
else
    error("Directory structure not valid. Folder must contain matlab_wrappers, databases, conda_environments, and bash_source.")
end

% check for a default conda environment
conda_home = "";
if isfolder("~/anaconda3")
    default_conda = input("Conda environment found at ~/anaconda3. Use this as CONDA_HOME? [y/n] ", "s");
    if any(strcmpi(["y","yes"],default_conda))
        disp("Using ~/anaconda3 as CONDA_HOME.")
        conda_home = "~/anaconda3";
    elseif any(strcmpi(["n","no"],default_conda))
        disp("Will use user-provided Conda path.")
    else
        disp("Unrecognized input. Please provide Conda path.")
    end
end
    
% get the conda home environment
if strcmp(conda_home, "")
    
    conda_home = input("Please enter your Conda environment directory: ", "s");
    
    if isfolder(conda_home)
        disp("Using "+donda_home+" as CONDA_HOME.")
    else
        while ~isfolder(conda_home)
            disp(conda_home + " is not a valid directory.")
            conda_home = input("Please enter your Conda environment directory: ", "s");
        end
    end

end

% check for a default docker environment
docker_home = "";
if isfile("/usr/local/bin/docker")
    default_docker = input("Docker executable found in /usr/local/bin. Use this as DOCKER_HOME? [y/n] ", "s");
    if any(strcmpi(["y","yes"],default_docker))
        disp("Using /usr/local/bin as DOCKER_HOME.")
        docker_home = "/usr/local/bin";
    elseif any(strcmpi(["n","no"],default_conda))
        disp("Will use user-provided Docker path.")
    else
        disp("Unrecognized input. Please provide Docker path.")
    end
end

% get the docker home environment
if strcmp(docker_home, "")
    
    docker_home = input("Please enter your Docker executable directory: ", "s");
    
    if isfolder(docker_home)
        disp("Using "+docker_home+" as DOCKER_HOME.")
    else
        while ~isfolder(docker_home)
            disp(docker_home + " is not a valid path.")
            docker_home = input("Please enter your Docker environment directory: ", "s");
        end
    end

end

% validate the conda home environment
disp("Checking the Conda environment...")
conda_home_contents = dir(conda_home);
folder_names = {conda_home_contents.name};
reqd_folders = ["condabin", "conda-meta", "bin"];

if all(ismember(reqd_folders,folder_names))
    disp("Conda environment is valid.")
else
    error("Conda environment is not valid- it looks like you're missing some folders. Please check the conda directory.")
end

% validate the docker environment
disp("Checking the Docker environment...")
[status, stdout] = system(docker_home+" docker image ls");
if status == 0
    disp("Docker looks good!")
else
    error("Docker could not run- please check that it is installed and that you provided the correct directory.")
end

% check for startup.m
home_files = dir(userpath);
if ismember("startup.m", {home_files.name})
    disp(" ");disp("startup.m detected in home directory; will append to existing file.")
else
    disp(" ");disp("startup.m not detected in home directory; will create new file.")
end

% set up path
full_conda_path = what(conda_home).path;
path_to_add = full_conda_path+"/condabin:"+full_conda_path+"/bin:"+docker_home+":";
setenv("PATH", path_to_add+getenv("PATH"));
conda_path_line = "setenv('PATH','" + path_to_add+getenv("PATH")+"');";
setenv("BIOSUITE_HOME", pwd);
home_directory_line="setenv('BIOSUITE_HOME','"+pwd+"');";

% open startup.m and add BioSuite paths
fileid = fopen(userpath+"/startup.m", "a+");
fprintf(fileid,conda_path_line);
fprintf(fileid, "\n" + home_directory_line);
fprintf(fileid, "\naddpath(genpath('"+pwd+"'))");
fclose(fileid);

% create conda environments
conda_envs = dir("conda_environments");
disp(" ");all_envs = input("Installing all Conda environments will use up to 50GB of disk space. Install all envs? [y/n] ", 's');

if ismember(lower(all_envs),["y","yes"])
    disp(" ");disp("Creating conda environments. This may take some time...")
else
    disp(" ");disp("Will perform selective Conda installation.")
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
        else
            disp("Skipping "+conda_envs(k).name + "...")
            continue
        end
    end
    
    str = "conda env create -f conda_environments/"+conda_envs(k).name;
    [stat, out] = system(str);
    
    if stat ~= 0
        disp("Environment creation had non-zero exit status for "+conda_envs(k).name+". Details:")
        disp(out)
    else
        disp("Successfully created "+conda_envs(k).name)
    end
end

disp("All conda environments created.")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%~
% databases and other external downloads %
%~
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% download the plasmid finder database
install_pf = input("Install PlasmidFinder database? [y/n] ",'s');
if ismember(lower(install_pf),["y","yes"])
    disp(" "); disp("Installing the PlasmidFinder database...");
    pf_string = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate plasmidfinder_env;download-db.sh";
    [stat, out] = system(pf_string);
    if stat == 0
        disp("PlasmidFinder database installed successfully!")
    else
        disp("PlasmidFinder database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping PlasmidFinder database. Note that PlasmidFinder will not function until the database is installed.")
end

% download the AMRPlus database
install_amr = input("Install AMRPlus database? [y/n] ",'s');
if ismember(lower(install_amr),["y","yes"])
    disp(" "); disp("Installing the AMRFinderPlus database...");
    amr_string = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate amrfinderplus_env;amrfinder -h";
    [stat, out] = system(amr_string);
    if stat == 0
        disp("AMRFinderPlus database installed successfully!")
    else
        disp("AMRFinderPlus database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping AMRPlus database. Note that AMRPlus will not function until the database is installed.")
end

% download the RGI CARDS database
install_cards = input("Install CARDS database? [y/n] ",'s');
if ismember(lower(install_cards),["y","yes"])
    disp(" "); disp("Installing the CARDS database...");
    card_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate rgi_env; " + ...
                "wget https://card.mcmaster.ca/latest/data; tar -xvf data ./card.json; " + ...
                "mv card.json $BIOSUITE_HOME/databases/; rgi load --card_json $BIOSUITE_HOME/databases/card.json;";
    [stat, out] = system(card_str);
    if stat == 0
        disp("CARDS database installed successfully!")
    else
        disp("CARDS database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping CARDS database. Note that RGI will not function until the database is installed.")
end

% load the geneSCF docker image; this must be downloaded and placed in the
% folder $BIOSUITE_HOME/binaries/ before running. The docker image can be
% obtained from https://drive.google.com/file/d/1hPHhhdFwHKWDltn5inkKZ1EMCxFcmurH/view?usp=sharing
str = "docker import $BIOSUITE_HOME/binaries/genescf_container.tar genescf:latest";
system(str);

% download the KmerFinder database
install_kmer = input("Install KmerFinder database? [y/n] ",'s');
if ismember(lower(install_kmer),["y","yes"])
    disp(" "); disp("Installing the KmerFinder database...");
    kmer_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate kmerfinder_env; " + ...
        "cd $BIOSUITE_HOME/databases; git clone https://bitbucket.org/genomicepidemiology/kmerfinder_db.git; " + ...
        "cd kmerfinder_db; KmerFinder_DB=$(pwd); bash INSTALL.sh $KmerFinder_DB bacteria 20190108_stable";
    [stat, out] = system(kmer_str);
    if stat == 0
        disp("KmerFinder database installed successfully!")
    else
        disp("KmerFinder database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping KmerFinder database. Note that KmerFinder will not function until the database is installed.")
end

% download the MLST database
install_kmer = input("Install MLST database? [y/n] ",'s');
if ismember(lower(install_kmer),["y","yes"])
    disp(" "); disp("Installing the MLST database...");
    kmer_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate mlst_env; " + ...
        "cd $BIOSUITE_HOME/databases; git clone https://bitbucket.org/genomicepidemiology/mlst_db.git; " + ...
        "cd mlst_db; MLST_DB=$(pwd); python INSTALL.py kma_index";
    [stat, out] = system(kmer_str);
    if stat == 0
        disp("MLST database installed successfully!")
    else
        disp("MLST database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping MLST database. Note that MLST will not function until the database is installed.")
end