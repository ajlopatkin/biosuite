function bacsort(input_dir, output_dir, db_name)

% Run the BacSort pipeline. Takes in an input directory of gzipped fastas
% in ".fna.gz" format (use format_fastas), the output directory to write
% the bacSort outputs into, and a db name for Mash. The output will be a
% folder of clustered .fna.gz files, and a cluster_accession file that maps
% the input fastas to each cluster. A tree folder also contains the
% phylogenetic tree in newick format that was used to cluster the genomes.

% make the output directory and a subfolder to hold the fasta inputs

if isfolder(output_dir)
   return 
end

mkdir(output_dir);
mkdir(output_dir+"analysis");
copyfile(input_dir, output_dir+"analysis/");

% run MASH on the input fastas- BacSort needs a file called
% 'mash_distances' in the input folder to run
mash_single(output_dir+"analysis/mash_distances", output_dir+"analysis/", db_name);

% run bacsort
str = "bash $BIOSUITE_HOME/bash_source/run_bacsort.sh";
prev_dir = cd(output_dir);
[status,cmdout] = system(str);
cd(prev_dir);

if status ~= 0
    disp("Error running BacSort! Output below...")
    disp(cmdout)
else

    clusters = output_dir + "cluster_accessions";
    fid = fopen(clusters);

    % rename files
    while true

        line = fgetl(fid);

        if ~ischar(line)
            break
        end

        line_split = split(line, "	");
        clustered_fasta = string(line_split(1)) + ".fna.gz";
        unclustered_fastas = split(line_split(2), ",");
        fasta_to_use = split(unclustered_fastas(1),"/");
        fasta_to_use = string(fasta_to_use(end));
        if contains(fasta_to_use, "*")
            fasta_to_use = extractBefore(fasta_to_use, strlength(fasta_to_use));
        end
        movefile(output_dir + "/clusters/" + clustered_fasta, output_dir + "/" + fasta_to_use);

    end
    
    % clean up folders
    str = "rm -rf " + output_dir + "/analysis";
    system(str);
    str = "rm -rf " + output_dir + "/clusters";
    system(str);
end