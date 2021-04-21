#!/bin/bash

#settings and directories
nodes="/mnt/db/wgs_identification/kaiju_db/nr/nodes.dmp"
names="/mnt/db/wgs_identification/kaiju_db/nr/names.dmp"
rank="genus"  #can be everything from superkingdom to species
rank2="species"
database="/mnt/db/wgs_identification/kaiju_db/nr/kaiju_db_nr.fmi"
inputfile=$1 
outputfile1=$2 # argument 2 unused in script, but necessary for snakemake
outputfile2=$3 # argument 3 unused in script, but necessary for snakemake
monsternr=$4

kaiju2table -t ${nodes} -n ${names} -r ${rank} -o kai_${monsternr}_${rank}_temp ${inputfile}
kaiju2table -t ${nodes} -n ${names} -r ${rank2} -o kai_${monsternr}_${rank2}_temp ${inputfile}

#Converts the bsub output from tab delimited to csv
tr '\t' ',' <kai_${monsternr}_${rank}_temp> kai_${monsternr}_${rank}.csv
tr '\t' ',' <kai_${monsternr}_${rank2}_temp> kai_${monsternr}_${rank2}.csv

#removes tab delimited files
rm kai_${monsternr}_${rank}_temp
rm kai_${monsternr}_${rank2}_temp

sleep 30s