#!/bin/bash

#from wgs_identification main folder: 
#bsub -q bio -n 4 -o logs/fastqctest_log ./scripts/fastqc.sh
    

#location folder for input files
inputfile_trimmed_R1=input/*R1*.fastq.gz
inputfile_R1=/mnt/scratch_dir/stoopvdr/2021-03_210330/210330_NB552493_0012_AHNGFYAFX2_0003/*R1*.fastq.gz
#settings
type=posttrim #output location in results/fastqc/... either 'pretrim' or 'posttrim'

for i in ${inputfile_trimmed_R1}
do
    j=${i/R1/R2}

    #i=R1
    #j=R2
    fastqc -o results/fastqc/${type} ${i}
    fastqc -o results/fastqc/${type} ${j}
   
done

