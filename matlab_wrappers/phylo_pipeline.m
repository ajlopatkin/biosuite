function phylo_pipeline(input_dir_single, input_dir_paired,ref_file,output_dir)
intermediate_output = output_dir + "snippy_temp/";
mkdir(intermediate_output);

snippy_multi(input_dir_single, input_dir_paired,ref_file,intermediate_output)
gubbins(intermediate_output + "core.full.aln", output_dir);

