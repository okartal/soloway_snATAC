rule samtools_nsort:
    input:
        "results/{unit}.bam"
    output:
        "results/{unit}_nsorted.bam"
    params:
        config['params']['samtools']['nsort']
    threads:
        config['threads']['samtools']
    wrapper:
        "0.27.1/bio/samtools/sort"