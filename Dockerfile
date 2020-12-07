# Version: 0.0.2
FROM ubuntu:18.04

MAINTAINER Xing Fu "bio.xfu@gmail.com"

RUN echo 'deb http://mirrors.ustc.edu.cn/CRAN/bin/linux/ubuntu xenial/' >> /etc/apt/sources.list; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9; \
    apt-get update; \
    apt-get install -y r-base r-base-dev libcurl4-openssl-dev libxml2-dev gdebi-core libapparmor1 psmisc supervisor libedit2 wget libssl-dev pdftk; \
    apt-get clean; \
    apt-get autoremove

# https://www.rstudio.com/products/shiny/download-server/
RUN wget https://download3.rstudio.org/ubuntu-14.04/x86_64/shiny-server-1.5.15.953-amd64.deb; \
    gdebi shiny-server-1.5.15.953-amd64.deb; \
    rm /gdebi shiny-server-1.5.15.953-amd64.deb

RUN R -e "install.packages(c('shiny', 'rmarkdown', 'tidyverse', 'gplots', 'plotrix', 'VennDiagram', 'httr', 'data.table', 'jsonlite', 'shinydashboard'), repos='http://mirrors.ustc.edu.cn/CRAN/')"

RUN R -e "install.packages(c('seqinr'), repos='http://mirrors.ustc.edu.cn/CRAN/')"

RUN wget https://mafft.cbrc.jp/alignment/software/mafft_7.402-1_amd64.deb;\
    gdebi -n mafft_7.402-1_amd64.deb;\
    rm mafft_7.402-1_amd64.deb;

ADD install_bioC.R /src/install_bioC.R

RUN Rscript /src/install_bioC.R && rm /src/install_bioC.R

RUN wget https://bioconductor.org/packages/release/bioc/src/contrib/DECIPHER_2.8.1.tar.gz;\
    R CMD INSTALL DECIPHER_2.8.1.tar.gz;

RUN R -e "install.packages('DT', repos='http://mirrors.ustc.edu.cn/CRAN/')"

RUN R -e "install.packages('devtools', repos='http://mirrors.ustc.edu.cn/CRAN/')"

RUN R -e "require(devtools); install_github('rCharts', 'ramnathv')"
 
RUN apt-get install -y libmariadb-client-lgpl-dev

RUN R -e "install.packages('RMySQL', repos='http://mirrors.ustc.edu.cn/CRAN/')"

RUN R -e "options(BioC_mirror='http://mirrors.ustc.edu.cn/bioc/'); source('http://bioconductor.org/biocLite.R'); biocLite('Gviz')"

RUN apt-get install -y parallel

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

