%Plasmid resistance gene finder%

clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%path to folder of input .fna files
input_dir = BasePath + "/demo/output/fasta_downloads/";

%List of file names on which to run pipeline. Must be .fna files. 
id_list = ["SAMN01911278";"SAMN02604038";"SAMN02604066"];

%Path to output file
output_path = BasePath + "demo/pipeline_output/plasmid_test1.xlsx";

%Enter 'y' to run RGI, 'n' to skip
rgi = 'y';

%Enter 'y' to run starAMR, 'n' to skip
starmar = 'y';

%Enter 'y' to run AMRfinderplus, 'n' to skip
%   if running amrfinder, enter db_flag 'p' (protein) or 'n' (nucleotide)
amrfinder = 'y';
amr_flag = 'n';

%Run Prokka? y/n
prokka = 'y';

%Run MOB? y/n
%    if running MOB, specify flag 't' for replicon typing and 'r' for reconstruction
mob = 'y';
mob_flag = 't';

%Run PlasmidFinder? y/n
plasmidfinder = 'y';
%%%%%%%%%%%%%%%%%%%%%%

%%%%%% PIPELINE %%%%%%
i = 1;
while i < length(id_list)
    id = id_list(i);
    input_fasta = input_path + id + ".fna";
    tool_output = input_path + id + "_plasmidOut/";
    mkdir(tool_output)
    plasmid_res(input_path, input_fasta, rgi, staramr, amrfinder, amr_flag, prokka, mob, mob_flag, plasmidfinder, tool_output)
    i = i + 1;
end
compile_resistance(input_path + "temp/", output_path)
%%%%%%%%%%%%%%%%%%%%%%
