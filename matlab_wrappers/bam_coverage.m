function coverage = bam_coverage(bam_file,output_dir)

if ~isdir(output_dir)
    mkdir(output_dir)
end

str = "bash /Users/alopatki/Documents/MATLAB/BioSuite/bash_source/bam_coverage.sh " + bam_file + " " + ...
    output_dir;

[status,cmdout] = system(str)


fid = fopen(output_dir + "coverage.txt");
avg_coverage = fgetl(fid);
fclose('all')
coverage = (extractAfter(avg_coverage,'= '));