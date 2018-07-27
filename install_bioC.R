#! /usr/bin/env Rscript

source("http://bioconductor.org/biocLite.R")
options(BioC_mirror="http://mirrors.ustc.edu.cn/bioc/")
biocLite(c('SRAdb','GO.db', 'GeneOverlap', 'Biostrings', 'XVector'))
