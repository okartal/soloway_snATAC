# config: config.yaml

rule all:
    input:
        expand("results/barcoded.nextseq.{read}.fastq.gz", read=['R1', 'R2'])

include: "rules/debarcode.smk"