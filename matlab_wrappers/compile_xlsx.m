function compile_xlsx(input_dir, output_path, type)
compile_str = "bash $BIOSUITE_HOME/bash_source/compile_xlsx.sh " + input_dir + " " + output_path + " " + type;
[stat] = system(compile_str);
if stat ~= 0
    disp("Error running final data compiler. Excel sheet for each .fna file can be found in " + input_dir + "temp/")
end

