# Lopatkin Lab Docker Image for GeneSCF analysis

FROM ubuntu 
MAINTAINER alopatkin@barnard.edu
ARG DEBIAN_FRONTEND=noninteractive TZ="America/New_York"
WORKDIR /root/genescf
ENTRYPOINT /bin/bash

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget git perl gawk unzip gzip sed grep curl apt-transport-https software-properties-common
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
RUN add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/'
RUN apt update && apt install -y r-base build-essential
RUN Rscript -e 'install.packages("ggplot2", repos="https://cloud.r-project.org")'
RUN git clone https://github.com/genescf/GeneSCF.git /root/genescf
RUN bash /root/genescf/prepare_database -db=KEGG -org=eco || :
RUN bash /root/genescf/prepare_database -db=GO_all -org=ecocyc || :

