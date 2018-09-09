configfile: 'config.yaml'

UNITS = config['sequencing units']

rule all:
    input:
        expand('results/barcoded.{unit}.{read}.fastq.gz', read=['R1', 'R2'], unit=UNITS),
        expand('results/{unit}.bam', unit=UNITS),
        expand('results/{unit}_nsorted.bam', unit=UNITS),
        expand('results/{unit}_csorted.bam', unit=UNITS),
        expand('results/{unit}_csorted.bam.bai', unit=UNITS),
        expand('results/{unit}.bed.gz', unit=UNITS),
        expand("results/{unit}_peaks.narrowPeak", unit=UNITS),
        expand("results/{unit}_peaks.xls", unit=UNITS),
        expand("results/{unit}_summits.bed", unit=UNITS),
        expand("results/{unit}.reads_per_cell", unit=UNITS),
        expand("results/{unit}.promoter_cov", unit=UNITS),
        expand("results/{unit}.reads_in_peak", unit=UNITS),
        expand("results/{unit}.xgi", unit=UNITS),
        expand("results/{unit}.mat", unit=UNITS),

include: 'rules/debarcode_scATAC.smk'
include: 'rules/map_bwamem.smk'
include: 'rules/samtools_nsort.smk'
include: 'rules/samtools_csort.smk'
include: 'rules/samtools_index.smk'
include: 'rules/preprocess_snATAC.smk'
include: 'rules/callpeak_macs2.smk'
include: 'rules/stats_reads-per-cell.smk'
include: 'rules/stats_promoter-coverage.smk'
include: 'rules/stats_reads-in-peak.smk'
include: 'rules/qc_cells.smk'
include: 'rules/cell_matrix.smk'
