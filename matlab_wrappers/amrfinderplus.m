function amrfinderplus(fasta_file,db_flag,output_file,organism)

% % # INPUTS (IN ORDER): 
% % #	+ 1. fasta_file - path to input fasta file
% % #	+ 2. db_flag - p or n
% % #	+ 3. output_file - file for output data
% % #	+ 4. organism - Taxon for point mutation screening
    
str = "bash $BIOSUITE_HOME/bash_source/amrfinderplus.sh " +...
    fasta_file + " " + db_flag + " " + output_file + " " + organism;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running AMRFinder! Output below...")
    disp(cmdout)
end
