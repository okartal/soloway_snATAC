configfile: 'config.yaml'

UNITS = config['sequencing units']

rule all:
    input:
        expand('results/barcoded.{unit}.{read}.fastq.gz', read=['R1', 'R2'], unit=UNITS),
        expand('{unit}.bam', unit=UNITS)

include: 'rules/debarcode_scATAC.smk'
include: 'rules/map_scATAC.smk'
