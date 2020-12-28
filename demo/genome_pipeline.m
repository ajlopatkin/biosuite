%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Pipeline tool can run any of the following tools on .fna files and combine 
%output into single excel sheet:
    % - RGI
    % - starAMR
    % - AMRfinderplus
    % - Kmerfinder
    % - Clermont Type
    % - MLST (sequence type)

% Identify tools to run below 
    % - 'y' to run tool
    % - 'n' to skip tool
 
%Additional inputs:
    % - id_list: list of .fna file names on which to run pipeline
    %     - all .fna files MUST be placed in one folder prior to running
    % - input_path: file path to .fna file folder
    % - combined_output: Path to store output excel sheet
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;close all;clc
BasePath = getenv("BIOSUITE_HOME");

%%%%% USER INPUT %%%%%
%path to folder of input .fna files
input_path = BasePath + "/demo/output/fasta_downloads/";

%List of file names on which to run pipeline. Must be .fna files. 
id_list = ["SAMN01911278";"SAMN02604038";"SAMN02604066";"SAMD00061087";"SAMEA1705959";"SAMD00060956";"SAMD00060955";"SAMD00060923";"SAMEA2272277";"SAMN02603258";"SAMEA2272237";"SAMN02603727";"SAMN02604221";"SAMN02603406";"SAMN01831189";"SAMD00056130";"SAMD00056131";"SAMD00168435";"SAMD00179457";"SAMN02641383";"SAMN03765122";"SAMN02800875";"SAMN03264844";"SAMN03262652";"SAMN02949643";"SAMN03252410";"SAMN03252413";"SAMN03252415";"SAMN03252416";"SAMN03252420";"SAMN03252421";"SAMN03252423";"SAMN03252424";"SAMN03252429";"SAMN03252431";"SAMN03252435";"SAMN03252439";"SAMN03252442";"SAMN03252444";"SAMN03252449";"SAMN03252453";"SAMN03252457";"SAMN03252458";"SAMN02949644";"SAMN03371467";"SAMN03612246";"SAMN03783363";"SAMN03963234";"SAMN03952643";"SAMN04209666";"SAMN02688213";"SAMN02688215";"SAMN03996288";"SAMN03455931";"SAMN02808332";"SAMN04851092";"SAMN04623227";"SAMN05177221";"SAMN05190012";"SAMN05407982";"SAMN05762409";"SAMN05853574";"SAMN06067968";"SAMN05511183";"SAMN05511182";"SAMN05511168";"SAMN06219547";"SAMN06219548";"SAMN06219550";"SAMN06250205";"SAMN06165999";"SAMN06166007";"SAMN04014902";"SAMN04096281";"SAMN07187744";"SAMN07192703";"SAMN07260764";"SAMN07273977";"SAMN07302603";"SAMN07339706";"SAMN06928086";"SAMN07594018";"SAMN07503734";"SAMN07503733";"SAMN07618129";"SAMN07618127";"SAMN07618126";"SAMN07618121";"SAMN07618120";"SAMN07716515";"SAMN07807399";"SAMN07807400";"SAMN07807403";"SAMN07509121";"SAMN04578538";"SAMN07656203";"SAMN04014858";"SAMN08161344";"SAMN08161340";"SAMN08161314";"SAMN08161195";"SAMN08161146";"SAMN06040386";"SAMN03455998";"SAMN08450093";"SAMN04014918";"SAMN08522749";"SAMN08581173";"SAMN07291512";"SAMN08579559";"SAMN08579565";"SAMN08579574";"SAMN08579578";"SAMN08579579";"SAMN08579581";"SAMN08579583";"SAMN08579585";"SAMN08630964";"SAMN02991245";"SAMN08579593";"SAMN08165042";"SAMN08668598";"SAMN08932127";"SAMN09227133";"SAMN09287630";"SAMN04014926";"SAMN09640158";"SAMN09710898";"SAMN04448503";"SAMN10023797";"SAMN10230268";"SAMN10250173";"SAMN10319568";"SAMN10163231";"SAMN10623993";"SAMN10768946";"SAMN02435896";"SAMN11087649";"SAMN10986381";"SAMN11333172";"SAMN11266496";"SAMN10784802";"SAMN12214771";"SAMN12214770";"SAMN12214769";"SAMN12214768";"SAMN12214767";"SAMN12512712";"SAMN12641172";"SAMN12789775";"SAMN13242782";"SAMN13242790";"SAMN13742197";"SAMN13756204";"SAMN13829544";"SAMN13829545";"SAMN13951924";"SAMN13951918";"SAMN14149865";"SAMN13978668";"SAMN14238615";"SAMN14482837";"SAMN14558608";"SAMN14558879";"SAMN14609787";"SAMN14609775";"SAMN14609770";"SAMN14609771";"SAMEA5128443"];

%Path to pipeline output file. Must be .xlsx. 
combined_output = BasePath + "/demo/pipeline_output/test_6.xlsx";

%Enter 'y' to run RGI, 'n' to skip
rgi = 'y';

%Enter 'y' to run starAMR, 'n' to skip
starmar = 'y';

%Enter 'y' to run AMRfinderplus, 'n' to skip
%   if running amrfinder, enter db_flag 'p' (protein) or 'n' (nucleotide)
amrfinder = 'y';
db_flag = 'n';

%Enter 'y' to run Clermont typer, 'n' to skip
clermont_type = 'y';

%Enter 'y' to run MLST for sequence type, 'n' to skip
sequence_type = 'y';

%Enter 'y' to run kmerfinder, 'n' to skip
kmerfinder = 'y';
%%%%%%%%%%%%%%%%%%%%%%

%%%%%% PIPELINE %%%%%%
i = 1;
mkdir(BasePath + combined_output)
while i < length(id_list)
    id = id_list(i);
    input_fasta = input_path + id + ".fna";
    tool_output = input_path + id + "_pipelineOut/";
    mkdir(tool_output)
    get_resistance(input_path, rgi, starmar, amrfinder, db_flag, clermont_type, sequence_type, kmerfinder, input_fasta, tool_output)
    i = i + 1;
end
compile_resistance(input_path + "temp/", combined_output)
%%%%%%%%%%%%%%%%%%%%%%