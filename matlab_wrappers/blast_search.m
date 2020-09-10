function blast_search(query_file,input_blast_db,output_blast,output_fasta,db_flag)

str = "bash $BIOSUITE_HOME/bash_source/blast_search.sh " + query_file + " " + input_blast_db + " "...
    + output_blast + " " + output_fasta + " " + db_flag;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running BLAST! Output below...")
    disp(cmdout)
end
