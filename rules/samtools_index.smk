rule samtools_index:
    input: "results/{unit}_csorted.bam"
    output: "results/{unit}_csorted.bam.bai"
    params:
        config['params']['samtools']['index']
    threads:
        config['threads']['samtools']
    wrapper:
        "0.27.1/bio/samtools/index"
