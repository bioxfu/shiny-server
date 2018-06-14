# Version: 0.0.1
FROM ubuntu:16.04

MAINTAINER Xing Fu "bio.xfu@gmail.com"

RUN echo 'deb http://mirrors.ustc.edu.cn/CRAN/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9; \
    apt-get update; \
    apt-get install -y r-base r-base-dev libcurl4-openssl-dev libxml2-dev gdebi-core libapparmor1 psmisc supervisor libedit2 wget libssl-dev pdftk; \
    apt-get clean; \
    apt-get autoremove

# https://www.rstudio.com/products/shiny/download-server/
RUN wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.6.875-amd64.deb; \
    gdebi -n shiny-server-1.5.6.875-amd64.deb; \
    rm /shiny-server-1.5.6.875-amd64.deb

RUN R -e "install.packages(c('shiny', 'rmarkdown', 'tidyverse', 'gplots', 'plotrix', 'VennDiagram', 'httr', 'data.table', 'jsonlite', 'shinydashboard'), repos='http://mirrors.ustc.edu.cn/CRAN/')"

RUN R -e "install.packages(c('seqinr'), repos='http://mirrors.ustc.edu.cn/CRAN/')"

ADD install_bioC.R /src/install_bioC.R

RUN Rscript /src/install_bioC.R && rm /src/install_bioC.R

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

