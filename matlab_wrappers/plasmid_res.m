function plasmid_res(input_path, input_fasta, id, rgi, staramr, amrfinder, amr_flag, prokka, mob, mob_flag, plasmidfinder, tool_output)
BasePath = getenv("BIOSUITE_HOME");

compile_args = strcat(rgi, staramr, amrfinder, prokka, mob, plasmidfinder);

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
    amrfinderplus(input_fasta,amr_flag,output_file)
end

%Staramr
if staramr == 'y'
    output_dir = tool_output + "staramr";
    disp("Running *AMR on id = " + id)
    staramr(output_dir,input_fasta)
end

if prokka == 'y'
    output_dir = tool_output + "prokka";
    prokka(input_fasta,output_dir,id)
end

if mob == 'y'
    mob(input_fasta,tool_output,mob_flag)
end

%plasmidfinder??

disp("Combining results for " + id)
str = "bash $BIOSUITE_HOME/bash_source/plasmid_res.sh " + tool_output + " " + excel_output + " " + id + " " + compile_args;

[status,cmdout] = system(str);
if status ~= 0
    disp("Error running Python Resistance Gene Finder! Output below...")
    disp(cmdout)
end
    

