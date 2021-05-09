# DESCRIPTION: Compiles output of multiple blast searches into one csv
# 
# INPUTS (IN ORDER): 
#	+ 1. input_dir - directory containing blast outputs
# 
# DATE UPDATED: 3/22/21
# AUTHOR: Claire Johnson

#########################
#~- ENVIRONMENT SETUP -~#
#########################


CONDA_BASE=$(conda info --base)

# Activate the conda environment
source $CONDA_BASE/etc/profile.d/conda.sh

# Parse the inputs
input_dir=$1

###################
#~- MAIN SCRIPT -~#
###################


python "$BIOSUITE_HOME"/bash_source/blast_pipeline.py -i "$input_dir"

