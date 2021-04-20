#!/bin/bash

#settings and directories
database=/mnt/db/kraken2-microbial-fatfree
inputfile=$1
outputfile=$2
monsternr=$3
threads=6
filenames=()
summarylogname="KRA_JOB_SUMMARY"
    
#replaces R1 with R2 for paired-end file   
R2File="R2"
i=$inputfile
j=${i/R1/$R2File}

#run kraken command
kraken2 --paired --db ${database} ${i} ${j} --threads ${threads} --report ${outputfile} --output kra_${monsternr}_fullout

# while [ ! -f kra_${monsternr}_out]
# do
#     sleep 2
#     echo "waiting for " kra_${monsternr}_out
# done    


       



