function genome_res(input_path, rgi, staramr, amrfinder, db_flag, clermont_type, sequence_type, kmerfinder, id, input_fasta, tool_output)
BasePath = getenv("BIOSUITE_HOME");

compile_args = strcat(rgi, staramr, amrfinder, clermont_type, sequence_type, kmerfinder);

excel_output = BasePath + input_path + "temp/";
mkdir(excel_output)

%RGI
if rgi == 'y'
    output_file = tool_output + "RGI";
    disp("Running RGI on id = " + id)
    rgi(input_fasta,output_file)
    T = readtable(output_file);
    writetable(T, temp_out + "RGI.xlsx")
end

%AMRfinder
if amrfinder == 'y'
    output_file = tool_output +"AMR.txt";
    disp("Running AMRfinder on id = " + id)
    amrfinderplus(input_fasta,db_flag,output_file)
end

%Staramr
if staramr == 'y'
    output_dir = tool_output + "staramr";
    disp("Running *AMR on id = " + id)
    staramr(output_dir,input_fasta)
end

if clermont_type == 'y'
    disp("Running ezclermont on id = " + id)
    output_file = tool_output + "clermont.txt";
    ezclermont(input_fasta,output_file)
end

if sequence_type == 'y'
    disp("Running MLST on id = " + id)
    output_dir = tool_output + "mlst/";
    mlst(input_fasta,output_dir)
end

%KmerFinder
if kmerfinder == 'y'
    disp("Running Kmerfinder on id = " + id)
    output_dir = tool_output + "kmer/";
    kmerfinder(input_fasta, output_dir)
    str = "cp " + output_dir + "results.spa " + tool_output + "kmer_results.csv"; system(str);
end

%Args to bash script: output directory, input directory
disp("Combining results for " + id)
str = "bash $BIOSUITE_HOME/bash_source/get_resistance.sh " + tool_output + " " + excel_output + " " + id + " " + compile_args;

[status,cmdout] = system(str);
if status ~= 0
    disp("Error running Python Resistance Gene Finder! Output below...")
    disp(cmdout)
end