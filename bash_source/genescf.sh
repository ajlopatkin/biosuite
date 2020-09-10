#!/bin/bash

# SCRIPT NAME: genescf.sh
# DESCRIPTION: Run the GeneSCF program to annotate a list of genes. Note 
#              that this requires Docker to be installed, and the provided
#              docker image must have been imported when BioSuite was
#              initialized.
# 
# CONDA ENVIRONMENTS USED: none
# TOOL DEPENDENCIES: none
# 
# INPUTS (IN ORDER): 
#	+ input_file: the name of the file containing a list of gene symbols.
#                 NOTE: this file must be in the output folder.
#   + output_dir: the directory to write outputs. Must contain input file.
#   + db_type: the database to use, either KEGG or GO_all
# 
# DATE UPDATED: 8/27/20
# AUTHOR: Allison Lopatkin

#########################
#~- ENVIRONMENT SETUP -~#
#########################

# Parse the inputs
input_file=$1
output_dir=$2
db_type=$3

if [[ "$db_type" == KEGG ]]; then
    org_type=eco
else
    org_type=ecocyc
fi

###################
#~- MAIN SCRIPT -~#
###################

docker run -d -v $output_dir:/genescf_mnt\
 --rm genescf:latest bash /genescf/geneSCF -m=normal\
 -i=/genescf_mnt/$input_file -t=sym -o=/genescf_mnt -db=$db_type\
 -p=yes -bg=4300 -org=$org_type