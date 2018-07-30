#! /usr/bin/env Rscript

options(BioC_mirror="http://mirrors.ustc.edu.cn/bioc/")
source("http://bioconductor.org/biocLite.R")
biocLite(c('SRAdb','GO.db', 'GeneOverlap', 'Biostrings', 'XVector'))
