function mlst(input_fasta,output_path,database)

str = "bash $BIOSUITE_HOME/bash_source/mlst.sh " + input_fasta + " " + output_path + " " + database;

prev_path = cd(output_path);
[status,cmdout] = system(str);
cd(prev_path)

if status ~= 0
    disp("Error running MLST! Output below...")
    disp(cmdout)
end

