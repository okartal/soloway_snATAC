rule samtools_sort:
    input:
        "results/{unit}.bam"
    output:
        "results/{unit}_nsorted.bam"
    params:
        config['params']['samtools sort']
    threads:
        config['threads']['samtools sort']
    wrapper:
        "0.27.1/bio/samtools/sort"