function prokka(input_fasta,output_dir,prefix_name,genus)

% run prokka
str = "bash $BIOSUITE_HOME/bash_source/prokka.sh " + input_fasta...
    + " " + output_dir + " " + prefix_name + " " + genus;
[status,cmdout] = system(str);

if status ~= 0
    disp("Error running Prokka! Output below...")
    disp(cmdout)
end

% run prokka2keg
str = "python $BIOSUITE_HOME/bash_source/prokka2kegg.py " +... 
    "-i " + output_dir + "/" + prefix_name + ".gbf -d $BIOSUITE_HOME/databases/idmapping_KO.tab.gz -o " + output_dir + "/prokka2keg.txt";
[status,cmdout] = system(str);


% combine prokka and keg
output_file_main = output_dir + "/" + prefix_name;
str = "sed $'s/,/|/g' " + output_file_main + ".tsv" + " > " + output_file_main + "temp.tsv"; system(str)
str = "sed $'s/\t/,/g' " + output_file_main + "temp.tsv" + " > " + output_file_main + ".csv"; system(str)
output_file_keg = output_dir + "/prokka2keg";
str = "sed $'s/\t/,/g' " + output_file_keg + ".txt" + " > " + output_file_keg + ".csv"; system(str)

main = readtable(output_file_main + ".csv");
keg = readtable(output_file_keg + ".csv",'Delimiter',',','ReadVariableNames',false);
main.KEG = cell(height(main),1);
for q = 1:height(keg)
    cur = keg.Var1{q};
    curKeg = keg.Var2{q};
    ind = find(strcmp(cur,main.locus_tag));
    if ~isempty(ind)
        main.KEG{ind} = curKeg;
    end
end

% save main prokka output with kegg info
writetable(main, output_dir + "/" + prefix_name + "_combined.xlsx")

