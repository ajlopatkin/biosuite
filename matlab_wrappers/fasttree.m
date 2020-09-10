function fasttree(output_tree,input_aln)

str = "bash $BIOSUITE_HOME/bash_source/fasttree.sh " +...
    output_tree + " " + input_aln;

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running FastTree! Output below...")
    disp(cmdout)
end
