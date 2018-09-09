rule samtools_csort:
    input:
        "results/{unit}.bam"
    output:
        "results/{unit}_csorted.bam"
    params:
        config['params']['samtools']['csort']
    threads:
        config['threads']['samtools']
    wrapper:
        "0.27.1/bio/samtools/sort"