function snippy_multi(input_dir,ref_file,output_dir)

curr_dir = cd(output_dir);
s = dir(input_dir);
names = {s.name}';
s(strcmp(names,".") | strcmp(names,"..") | contains(names,"DS")) = [];
output_tab = output_dir + "list.tab";

if isfile(output_tab)
    delete(output_tab);
end

for k = 1:length(s)
    if strcmp(s(k).name, ".") || strcmp(s(k).name, "..")
        continue
    end
    
    curr_file = s(k).folder + "/" + s(k).name;
    
    if strcmp(curr_file, ref_file)
        continue
    end
    
    curr_name = split(s(k).name,".");
    curr_name = curr_name{1};
    
    fid = fopen(output_tab, "a+");
    curr_line = curr_name + "	" + curr_file+"\n";
    fprintf(fid, curr_line);
    fclose(fid);
end

str = "bash $BIOSUITE_HOME/bash_source/snippy_multi.sh " +...
    output_tab + " " + ref_file + " " + output_dir;

[status,cmdout] = system(str)

if status ~= 0
    disp("Error running Snippy! Output below...")
    disp(cmdout)
end

cd(curr_dir);

end
    