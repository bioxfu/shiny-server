# Version: 0.0.1
FROM ubuntu

MAINTAINER Xing Fu "bio.xfu@gmail.com"

RUN perl -p -i.orig -e 's/archive.ubuntu.com/mirrors.aliyun.com\/ubuntu/' /etc/apt/sources.list; \
    echo 'deb http://mirrors.ustc.edu.cn/CRAN/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list; \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9; \
    apt-get update; \
    apt-get install -y r-base r-base-dev libcurl4-openssl-dev libxml2-dev gdebi-core libapparmor1 psmisc supervisor libedit2 wget; \
    apt-get clean; \
    apt-get autoremove

RUN wget https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.4.0.721-amd64.deb; \
    gdebi -n shiny-server-1.4.0.721-amd64.deb; \
    rm /shiny-server-1.4.0.721-amd64.deb

RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='http://mirrors.ustc.edu.cn/CRAN/')"

ADD install_bioC.R /src/install_bioC.R

RUN Rscript /src/install_bioC.R && rm /src/install_bioC.R

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]

