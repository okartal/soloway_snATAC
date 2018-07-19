configfile: 'config.yaml'

UNITS = config['sequencing units']

rule all:
    input:
        expand('results/barcoded.{unit}.{read}.fastq.gz', read=['R1', 'R2'], unit=UNITS),
        expand('results/{unit}_tmp/nextseq.umap.{suf}', suf=['bam', 'corrected.bam', 'corrected.nsorted.bam'], unit=UNITS)

include: 'rules/scATAC_debarcode.smk'
include: 'rules/scATAC_map.smk'
