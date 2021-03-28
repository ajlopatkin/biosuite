%%%%%%%% database installer %%%%%%%

disp(" ")
disp("This program will install selected databases, if not yet installed")
disp("Checking for installed databases...")

pf_check = 0;
amr_check = 0;
rgi_check = 0;
kmer_check = 0;
mlst_check = 0;
prokka2kegg_check = 0;

[stat] = system("cd $BIOSUITE_HOME/databases");
if stat ~= 0
    disp("Error checking for current databases. Continuing without check.")
end
if isfile("idmapping_KO.tab.gz")
    prokka2kegg_check = 1;
end
if isfolder("kmerfinder_db")
    kmer_check = 1;
end
if isfolder("mlst_db")
    mlst_check = 1;
end
if isfile("cards.json")
    rgi_check = 1;
end
[stat] = system("cd $BIOSUITE_HOME");
if stat ~= 0
    disp("Error checking for current databases. Continuing without check.")
end

if rgi_check ~= 0
    disp("CARDS database detected. Continuing...")
else
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
        disp("Skipping CARDS database.")
    end
end

% download the KmerFinder database
if kmer_check ~= 0
    disp("KmerFinder database detected. Continuing...")
else
    disp(" ")
    install_kmer = input("Install KmerFinder database? Required for KmerFinder function. [y/n] ",'s');
    if ismember(lower(install_kmer),["y","yes"])
        disp(" "); disp("Installing the KmerFinder database...");
        kmer_str = "CONDA_BASE=$(conda info --base);source $CONDA_BASE/etc/profile.d/conda.sh;conda activate cge_env; " + ...
            "cd $BIOSUITE_HOME/databases; git clone https://bitbucket.org/genomicepidemiology/kmerfinder_db.git; " + ...
            "cd kmerfinder_db; KmerFinder_DB=$(pwd); bash INSTALL.sh $KmerFinder_DB bacteria latest";
        [stat, out] = system(kmer_str);
        if stat == 0
            disp("KmerFinder database installed successfully!")
        else
            disp("KmerFinder database did not install successfully; error below:")
            disp(out)
        end
    else
        disp("Skipping KmerFinder database")
    end
end

% download the MLST database
if mlst_check ~= 0
    disp("MLST database detected. Continuing...")
else
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
        disp("Skipping MLST database")
    end
end

% download the Prokka2Kegg database

if prokka2kegg_check ~= 0
    disp("Prokka2Kegg database detected. Continuing...")
else
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
        disp("Skipping Prokka2Kegg database")
    end
end
% download the plasmid finder database
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
    disp("Skipping PlasmidFinder database")
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
    disp("Skipping AMRPlus database.)
end
