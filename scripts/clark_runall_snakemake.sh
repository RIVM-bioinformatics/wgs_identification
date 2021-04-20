#!/bin/bash
# $1 = outputfile
# $2 = inputfile

#settings and directories
database=/mnt/db/wgs_identification/clark_db
targetfile=/mnt/db/wgs_identification/clark_db/targets.txt
inputfile=$1
outputfile=$2
monsternr=$3
threads=6
kmersize=21
mode=0
summarylogname="CLA_JOB_SUMMARY"


#runs CLARK for all R1 and R2 files in var "inputfile"

#creates i and j variable for the forward(R1) and reverse(R2) respectivly   
R2File="R2"
i=$inputfile
j=${i/R1/$R2File}
#CLARK command
CLARK -n ${threads} -k ${kmersize} -T ${targetfile} -D ${database} -P ${i} ${j} -R cla_${monsternr}_out -m ${mode}



