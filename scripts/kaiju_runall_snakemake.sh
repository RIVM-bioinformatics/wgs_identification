#!/bin/bash

#settings and directories
nodes=/mnt/db/wgs_identification/kaiju_db/nr/nodes.dmp
database=/mnt/db/wgs_identification/kaiju_db/nr/kaiju_db_nr.fmi
inputfile=$1
outputfile=$2
threads=6
mode="greedy"       #only use "greedy" or "mem", default greedy
mismatch="-e 3"     #only use when mode="greedy" if mem leave empty, default "-e 3" with quotations
minlenght=11        #minimum match length, default 11
minscore="-s 65"    #minimum match score in greedy, only use when mode=greedy else leave empty, default "-s 65" with quotations
filenames=()
summarylogname="KAI_JOB_SUMMARY"


    
#replaces R1 with R2 for paired-end file   
R2File="R2"
i=$inputfile
j=${i/R1/$R2File}
#Kaiju Command    
kaiju -z ${threads} -t ${nodes} -f ${database} -i ${i} -j ${j} -o ${outputfile} -a ${mode} -m ${minlenght} ${mismatch} ${minscore}

sleep 5m