function snippy_multi(input_dir_single, input_dir_paired,ref_file,output_dir)
BasePath = getenv("BIOSUITE_HOME");
config_out_path = output_dir + "snippy_input.tab";

str = "bash " + BasePath + "/bash_source/snippy_config.sh " + input_dir_single + " " + input_dir_paired + " " + config_out_path + " " + ref_file + " " + output_dir;

[status,cmdout] = system(str);
disp(cmdout)
if status ~= 0
    disp("Error running Snippy! Output below...")
    disp(cmdout)
end