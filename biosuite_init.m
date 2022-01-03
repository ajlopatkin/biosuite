%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% BIOSUITE INSTALLER V0.2
%
% Last Build: 9/9/20
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
% Docker must be installed in order to use GeneSCF; please see the Docker
% website at https://docs.docker.com/get-docker/ to install.
%
% For issues, please contact the Lopatkin Lab at www.lopatkinlab.com.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
disp("Welcome to BioSuite!")
disp("This script will install the BioSuite MATLAB tools and configure your environment for use.")
disp(" ");disp("Checking available disk space...")

FileObj = java.io.File("/");
usable_gb = FileObj.getUsableSpace/1e9;

if usable_gb > 150
    disp("Found >150GB free disk space available.")
elseif usable_gb > 50
    disp("Found 50-150GB available; partial install recommended.")
else
    disp("<50GB disk space available; the full install of BioSuite will take ~100GB disk space. Consider freeing up some disk space before continuing.")
    keep_going = input("Continue with install? [y/n] ",'s');
    if ismember(lower(keep_going),["y","yes"])
        disp("Continuing with install.")
    else
        disp("Exiting...")
        return
    end
end

disp(" ");disp("Checking current folder structure...")

% check the current directory for biosuite contents
if isfolder("databases") && isfolder("conda_envs")...
        && isfolder("bash_source") && isfolder("matlab_wrappers")
    disp("Directory structure OK."); disp(" ")
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
        disp("Using "+conda_home+" as CONDA_HOME.")
    else
        while ~isfolder(conda_home)
            disp(conda_home + " is not a valid directory.")
            conda_home = input("Please enter your Conda environment directory, or 'e' to exit: ", "s");
            if any(strcmpi(["e","exit"],conda_home))
                disp("Exiting...")
                return
            end
        end
    end

end

% check for a default docker environment
docker_home = "";
disp(" ")
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
            docker_home = input("Please enter your Docker environment directory, or 'e' to exit: ", "s");
            if any(strcmpi(["e","exit"],docker_home))
                disp("Exiting...")
                return
            end
        end
    end

end

% validate the conda home environment
disp(" "); disp("Checking the Conda environment...")
conda_home_contents = dir(conda_home);
folder_names = {conda_home_contents.name};
reqd_folders = ["condabin", "conda-meta", "bin"];

if all(ismember(reqd_folders,folder_names))
    disp("Conda environment is valid.")
else
    error("Conda environment is not valid- it looks like you're missing some of the following folders: condabin, conda-meta, bin. Please check the conda directory.")
end

% validate the docker environment
disp("Checking the Docker environment...")
[status, stdout] = system(docker_home+"/docker image ls");
if status == 0
    disp("Docker looks good!")
else
    error("Docker could not run- please check that it is installed and that you provided the correct directory.")
end

% check for startup.m
home_files = dir(userpath);
add_to_startup = 0;
make_startup = 0;
if ismember("startup.m", {home_files.name})
    disp(" ");
    make_startup = input("startup.m detected in home directory; append to existing file? [y/n] ", 's');
    if ismember(lower(make_startup),["y","yes"])
        make_startup = 1;
        add_to_startup = 1;
        disp("Will append to existing startup.m")
    else
        make_startup = input("Are you sure? This may break BioSuite! [y/n] ", 's');
        if ismember(lower(make_startup),["y","yes"])
            make_startup = 0;
            disp("Skipping path setup. WARNING: THIS MAY CAUSE CONDA OR OTHER TOOLS TO FAIL!")
        else
            make_startup = 1;
            add_to_startup = 1;
            disp("Will append to existing startup.m")
        end
    end
else
    make_startup = 1;
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
if make_startup == 1
    fileid = fopen(userpath+"/startup.m", "a+");
    if add_to_startup == 1
        fprintf(fileid,"\n" + conda_path_line);
    else
        fprintf(fileid,conda_path_line);
    fprintf(fileid, "\n" + home_directory_line);
    fprintf(fileid, "\naddpath(genpath('"+pwd+"'))");
    fclose(fileid);
    end
end
% create conda environments
conda_envs = dir("conda_envs");
disp(" ");all_envs = input("Installing all Conda environments will use up to 50GB of disk space. Install all envs? [y/n] ", 's');

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
        elif ismember(lower(do_env),["n","no"])
            disp("Skipping "+conda_envs(k).name + "...")
            continue
        else
            disp("Unrecognized input. Skipping" +conda_envs(k).name + "...")
            continue
        end
    end
    
    str = "conda env create -f conda_envs/"+conda_envs(k).name;
    [stat, out] = system(str);
    
    if stat ~= 0
        disp("Environment creation had non-zero exit status for "+conda_envs(k).name+". Details:")
        disp(out)
    else
        disp("Successfully created "+conda_envs(k).name)
    end
end

disp("All requested conda environments created.")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%~
% databases and other external downloads %
%~
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% download the plasmid finder database
disp(" ")
install_pf = input("PlasmidFinder database is required for PlasmidFinder function. Install PlasmidFinder database? [y/n] ",'s');
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
    disp("For future database installs, run database_installer.m")
end

% download the AMRPlus database
disp(" ")
install_amr = input("Install AMRPlus database? Required for AMRPlus function. [y/n] ",'s');
if ismember(lower(install_amr),["y","yes"])
    disp(" "); disp("Installing the AMRFinderPlus database...");
    amr_string = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate amrfinderplus_env;amrfinder -u";
    [stat, out] = system(amr_string);
    if stat == 0
        disp("AMRFinderPlus database installed successfully!")
    else
        disp("AMRFinderPlus database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping AMRPlus database. Note that AMRPlus will not function until the database is installed.")
    disp("For future database installs, run database_installer.m")
end

% download the RGI CARDS database
disp(" ")
install_cards = input("Install CARDS database? Required for RGI. [y/n] ",'s');
if ismember(lower(install_cards),["y","yes"])
    disp(" "); disp("Installing the CARDS database...");
    card_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate rgi_env; " + ...
                "cd $BIOSUITE_HOME/databases; wget https://card.mcmaster.ca/latest/data; tar -xvf data ./card.json; " + ...
                "rgi load --card_json $BIOSUITE_HOME/databases/card.json;";
    [stat, out] = system(card_str);
    if stat == 0
        disp("CARDS database installed successfully!")
    else
        disp("CARDS database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping CARDS database. Note that RGI will not function until the database is installed.")
    disp("For future database installs, run database_installer.m")
end

%build the geneSCF docker image
disp(" ")
disp("Building GeneSCF Docker image...")
docker_str = "docker build -t genescf:v1 $BIOSUITE_HOME/Dockerfile";
[stat, out] = system(docker_str, '-echo');
if stat == 0
    disp("GeneSCF Docker image imported successfully!")
else
    disp("GeneSCF docker image did not import successfully; error below:")
    disp(out)
end

% download the KmerFinder database
disp(" ")
install_kmer = input("Install KmerFinder database? Required for KmerFinder function. [y/n] ",'s');
if ismember(lower(install_kmer),["y","yes"])
    disp(" "); disp("Installing the KmerFinder database...");
    kmer_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate cge_env; " + ...
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
    disp("For future database installs, run database_installer.m")
end

% download the MLST database
disp(" ")
install_mlst = input("Install MLST database? Required for MLST function. [y/n] ",'s');
if ismember(lower(install_mlst),["y","yes"])
    disp(" "); disp("Installing the MLST database...");
    mlst_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate cge_env; " + ...
        "cd $BIOSUITE_HOME/databases; git clone https://bitbucket.org/genomicepidemiology/mlst_db.git; " + ...
        "cd mlst_db; MLST_DB=$(pwd); python INSTALL.py kma_index";
    [stat, out] = system(mlst_str);
    if stat == 0
        disp("MLST database installed successfully!")
    else
        disp("MLST database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping MLST database. Note that MLST will not function until the database is installed.")
    disp("For future database installs, run database_installer.m")
end

% download the Prokka2Kegg database
disp(" ")
install_p2k = input("Install Prokka2Kegg database? [y/n] ",'s');
if ismember(lower(install_p2k),["y","yes"])
    disp("Installing the Prokka2Kegg database...")
    p2k_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate cge_env; " + ...
            "cd $BIOSUITE_HOME/databases; wget https://github.com/SilentGene/Bio-py/raw/master/prokka2kegg/idmapping_KO.tab.gz";
    [stat, out] = system(p2k_str);
    if stat == 0
        disp("Prokka2Kegg database installed successfully!")
    else
        disp("Prokka2Kegg database did not install successfully; error below:")
        disp(out)
    end
else
    disp("Skipping Prokka2Kegg database. Note that Prokka will not function until the database is installed.")
    disp("For future database installs, run database_installer.m")
end

disp(" ")
disp("Biosuite has been initialized. Please restart MATLAB for all changes to take effect.")
disp("For issues, ideas or questions, contact the Lopatkin lab at lopatkinlab.com")
