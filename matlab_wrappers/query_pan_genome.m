function query_pan_genome(output_dir,query_flag,groups,list1,varargin)

if nargin == 4
    str = "bash $BIOSUITE_HOME/bash_source/query_pan_genome.sh " +...
        output_dir + " " + query_flag + " " + groups + " " + list1;
else
    str = "bash $BIOSUITE_HOME/bash_source/query_pan_genome.sh " +...
        output_dir + " " + query_flag + " " + groups + " " + list1 + " " + varargin{1};
end

[status,cmdout] = system(str);

if status ~= 0
    disp("Error running QueryPanGenome! Output below...")
    disp(cmdout)
end

