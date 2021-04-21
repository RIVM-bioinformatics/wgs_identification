#!/bin/bash
#from wgs_identification main folder: 
#   bsub -q bio -o logs/trimmomaticfullrun_log -n 8 ./scripts/trimmomatic.sh

#trimmomatic is optimized for 4 threads, use multiple of 4 for optimal performance 

#settings
inputfile_R1=/mnt/scratch_dir/stoopvdr/2021-03_210330/210330_NB552493_0012_AHNGFYAFX2_0003/*R1*.fastq.gz
prestring="0003/"
poststring="_R"

for i in ${inputfile_R1}
do
    #!HARDCODED, configure in settings. removes pre string and post string. whats left is monsternr
    #this could be replaced by the monsterID.param in snakemake/snakefile.
    trimID="${i#*${prestring}}"
    monsternr=${trimID%${poststring}*}

    # j= R2 file
    j=${i/R1/R2}

    output_R1="input/${monsternr}_R1.fastq.gz"
    output_R1_unpaired="input/unpaired/${monsternr}_R1_unpaired.fastq.gz"
    output_R2="input/${monsternr}_R2.fastq.gz"
    output_R2_unpaired="input/unpaired/${monsternr}_R2_unpaired.fastq.gz"
    adapters="NexteraPE-PE.fa"
    #runs trimmomatic                                                                                                      #these were reccommended settings from trimmomatic manual
    trimmomatic PE ${i} ${j} ${output_R1} ${output_R1_unpaired} ${output_R2} ${output_R2_unpaired} ILLUMINACLIP:${adapters}:2:30:10:2:keepBothReads LEADING:3 TRAILING:3 MINLEN:36 #default settings
done