#!/bin/bash
#*grabs all S, S1, S2, G, G1 and G2's from a kra_*_report file
inputfile=$1
outputfile=$2
monsternr=$3
grep -w "S\|S1\|S2\|G\|G1\|G2" ${inputfile} >kra_${monsternr}_temp
#tr: converts tsv to csv format
#rm removes temporary file afterwards
tr '\t' ',' <kra_${monsternr}_temp> ${outputfile}
rm kra_${monsternr}_temp 






