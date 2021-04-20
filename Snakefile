#clark rules
rule clark_classify_snakemake:
    input:  "cla_{monsternr}_out.csv"
    output: "cla_{monsternr}_report.csv"
    params: monsterID = "{monsternr}"
    conda: "envs/WGSpipeline_ramon_env.yml"
    log:    "logs/clark_classify_snakemake.log"
    shell:  "scripts/clark_classifyall_snakemake.sh {input} {output}" 

rule clark_runall_snakemake:
    input:  "input/{monsternr}_R1.fastq"
    output: "cla_{monsternr}_out.csv"
    params: monsterID = "{monsternr}"
    threads: 6
    resources:  mem_mb=150000
    conda:  "envs/WGSpipeline_ramon_env.yml"
    log:    "logs/{params.monsterID}_clark_runall_snakemake.log"
    shell:  "scripts/clark_runall_snakemake.sh {input} {output} {params.monsterID}"

#kraken2 rules
rule kraken2_isolateGS_snakemake: 
    input:  "kra_{monsternr}_out"
    output: "kra_{monsternr}_report.csv"
    params: monsterID = "{monsternr}"
    log:    "logs/{params.monsterID}_kraken2_isolateGS_snakemake.log"
    conda:  "envs/WGSpipeline_ramon_env.yml"
    shell:  "scripts/kraken2_isolateGS_snakemake.sh {input} {output} {params.monsterID}"

rule kraken2_runall_snakemake:
    input:  "input/{monsternr}_R1.fastq.gz"
    output: "kra_{monsternr}_out"
    params: monsterID = "{monsternr}"
    log:    "logs/{params.monsterID}_kraken2_runall_snakemake.log"
    threads: 6
    resources:  mem_mb=150000
    conda:  "envs/WGSpipeline_ramon_env.yml"
    shell:  "scripts/kraken2_runall_snakemake.sh {input} {output} {params.monsterID}"

#kaiju rules
rule kaiju_runall_snakemake:
    input:  "input/{monsternr}_R1.fastq.gz"
    output: "kai_{monsternr}_out"
    params: monsterID = "{monsternr}"
    log:    "logs/{params.monsterID}_kaiju_runall_snakemake.log"
    threads: 6
    resources:  mem_mb=150000
    conda:  "envs/WGSpipeline_ramon_env.yml"
    shell:  "scripts/kaiju_runall_snakemake.sh {input} {output}"

rule kaiju_classify_snakemake:
    input:  "kai_{monsternr}_out"
    output: "kai_{monsternr}_genus.csv" , "kai_{monsternr}_species.csv"
    params: monsterID = "{monsternr}"
    log:    "logs/{params.monsterID}_kaiju_classify_snakemake.log"
    conda:  "envs/WGSpipeline_ramon_env.yml"
    shell:  "scripts/kaiju_classifyall_snakemake.sh {input} {output} {params.monsterID}"

rule kaiju_combine_snakemake:
    input:  "kai_{monsternr}_genus.csv" , "kai_{monsternr}_species.csv"
    output: "kai_{monsternr}_report.csv"
    params: monsterID = "{monsternr}"
    log:    "logs/{params.monsterID}_kaiju_combine_snakemake.log"
    conda:  "envs/WGSpipeline_ramon_env.yml"    
    shell:  "python scripts/kaiju_combine_snakemake.py"  +" "+  "kai_{params.monsterID}_genus.csv"  +" "+  "kai_{params.monsterID}_species.csv"  +" "+  "{params.monsterID}"

#combinetable
rule combine2table_snakemake:
    input:  "cla_{monsternr}_report.csv" , "kra_{monsternr}_report.csv" , "kai_{monsternr}_report.csv"
    output: "results/combined_{monsternr}.csv"
    params: monsterID = "{monsternr}"
    log:    "logs/{params.monsterID}_combine2table_snakemake.log"
    conda:  "envs/WGSpipeline_ramon_env.yml"
    shell:  "python scripts/combine2table_snakemake.py"  +" "+  "cla_{params.monsterID}_report.csv"  +" "+  "kra_{params.monsterID}_report.csv"  +" "+  "kai_{params.monsterID}_report.csv"  +" "+  "{params.monsterID}"
    