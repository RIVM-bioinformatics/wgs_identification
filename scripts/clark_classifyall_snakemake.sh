#!/bin/bash

#settings and directories
#$1 = outputfile
#$2 = inputfile
database="/mnt/db/wgs_identification/clark_db"
inputfile=$1
outputfile=$2


#uses the getAbundance script from clark, used from the installed folder.
#"./home/stoopvdr/.conda/envs/CLARK/opt/clark/exe/getAbundance -F ${inputfile} -D ${database}>${outputfile}" 
    
/home/stoopvdr/.conda/envs/WGSpipeline_ramon_env/opt/clark/estimate_abundance.sh -F ${inputfile} -D ${database} > ${outputfile}