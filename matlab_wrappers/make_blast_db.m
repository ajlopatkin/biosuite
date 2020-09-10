function make_blast_db(input_fasta,fast_type,output_dir)

str = "bash $BIOSUITE_HOME/bash_source/make_blast_db.sh " + input_fasta + " " + fast_type + " "...
    + output_dir;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running MakeBlastDB! Output below...")
    disp(cmdout)
end
