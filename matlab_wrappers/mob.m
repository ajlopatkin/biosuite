function mob(input_file,output_dir,recon_flag)

% % # INPUTS (IN ORDER): 
% % #	+ 1. input_file - input fasta
% % #	+ 2. output_dir - output directory only if mob_recon and specify filename if mob_typer
% % #	+ 3. recon_flag - r if using mob_recon and t if using mob_typer
% % #
% % # 

str = "bash $BIOSUITE_HOME/bash_source/mob.sh " + input_file + " "...
     + output_dir + " " + recon_flag;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running MobSuite! Output below...")
    disp(cmdout)
end