# biosuite
BioSuite is a collection of MATLAB functions that use common bacterial genomics tools.

## Description

Rigorous bioinformatics pipelines usually require integrating multiple tools that each depend on different langugages with complex dependencies. These obstacles are prohibitively challenging for students with experience in one (or less) programming language and/or more advanced scientists without a computational background. BioSuite is a compilation of the most heavily utilized bacterial genomics tools including whole genome alignment, de novo assembly, SNP calling and functional annotations/analyses. MATLAB wrappers provide a simple interface to back-end source code, and leverages independent conda environments to avoid dependency conflicts. More advanced users can easily follow the template to integrate additional tools that are not included.

## Getting Started

### Dependencies

* All tools were tested on Mac OSX 10.15.5 and MATLAB R2019b
* Conda
* Docker

### Installing

* Installing Conda: please see https://www.anaconda.com/products/individual to download Conda. Scroll to the bottom and select either the command line or graphical installer for your OS (either should be Python 3.8+). When installing, the preferred install location is ~/anaconda3; other locations can be used, but you will have to provide this install location to the BioSuite installer.
* Installing Docker: please see https://www.docker.com/products/docker-desktop to download Docker Desktop. Download and install the latest stable version. You should end up with a Docker executable at /usr/local/bin/docker (if using Mac OSX).
* Clone this repository to your MATLAB home directory (i.e., ~/Documents/MATLAB/) by entering `cd ~/Documents/MATLAB; git clone https://github.com/ajlopatkin/biosuite.git` in terminal. If your MATLAB home directory is not ~/Documents/MATLAB, change the above command accordingly. You can also choose to download an archive of this repo and unzip it into your MATLAB home directory.
* Download the GeneSCF docker image from https://drive.google.com/file/d/1hPHhhdFwHKWDltn5inkKZ1EMCxFcmurH/view?usp=sharing (this is a compressed Docker image) and place it in the databases folder of your BioSuite installation.
* In MATLAB, navigate to the BioSuite folder, and run `biosuite_init.m`. This will automatically install all of the Conda environments and databases that are required for BioSuite to run. You must restart MATLAB after this script completes for path variables and other changes to take effect.

### Executing program

The BioSuite folder includes demos for (almost) every tool that is installed. Run the scripts in `BIOSUITE_HOME/demo` to get a sense for how each functions; in general, these tools are just used the same way as other MATLAB functions. Once the initialization script is run, the functions will be placed on your path, so that you can run them from anywhere in MATLAB.

## Authors

Allison Lopatkin (https://lopatkinlab.com)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
