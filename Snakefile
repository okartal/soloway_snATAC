configfile: 'config.yaml'

UNITS = config['sequencing units']

rule all:
    input:
        expand('results/barcoded.{unit}.{read}.fastq.gz', read=['R1', 'R2'], unit=UNITS),
        expand('results/{unit}.bam', unit=UNITS),
        expand('results/{unit}.bed.gz', unit=UNITS),
        expand("results/{unit}_peaks.narrowPeak", unit=UNITS),
        expand("results/{unit}_peaks.xls", unit=UNITS),
        expand("results/{unit}_summits.bed", unit=UNITS),
        expand("results/{unit}.reads_per_cell", unit=UNITS),
        expand("results/{unit}.promoter_cov", unit=UNITS),

include: 'rules/debarcode_scATAC.smk'
include: 'rules/map_scATAC.smk'
include: 'rules/samtools_sort.smk'
include: 'rules/preprocess_snATAC.smk'
include: 'rules/callpeak_macs2.smk'
include: 'rules/reads_per_cell.smk'
include: 'rules/bedtools_promotercov.smk'
