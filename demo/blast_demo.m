% This makes a blast database from a single or multifasta file, and then
% runs the blast search using a query sequence

% % % # INPUTS (IN ORDER) FOR make_blast_db.m: 
% % % #	+ 1. input_fasta - input single or multi .fasta file
% % % #	+ 2. fasta_type - 'nucl' or 'prot'
% % % #	+ 3. output_dir - path to output directory with database name
BasePath = getenv("BIOSUITE_HOME");
input_fasta = BasePath + "/demo/demo_data/demo_genome.fasta";
fasta_type = 'nucl';
output_dir = BasePath + "/demo/output/db_demo_genome";
make_blast_db(input_fasta,fasta_type,output_dir)

% % % # INPUTS (IN ORDER) FOR blast_search.m: 
% % % #	+ 1. query_file - fasta query file for blast search
% % % #	+ 2. input_blast_db - out_dir from above
% % % #	+ 3. output_blast - name of text file output
% % % #	+ 4. output_fasta - name of fasta file output
% % % #	+ 5. db_flag - database flag ('n' or 'p')
query_file = BasePath + "/demo/demo_data/katG.fasta";
input_blast_db = output_dir;
output_blast = BasePath + "/demo/output/blast_output.txt";
output_fasta = BasePath + "/demo/output/blast_output.fasta";
db_flag = "n";
blast_search(query_file,input_blast_db,output_blast,output_fasta,db_flag)