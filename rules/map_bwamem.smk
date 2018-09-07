rule map_bwamem:
    input:
        reads=["results/barcoded.{unit}.R1.fastq.gz", "results/barcoded.{unit}.R2.fastq.gz"]
    output:
        "results/{unit}.bam"
    log:
        "results/logs/map_bwamem/{unit}.log"
    benchmark:
        "results/benchmarks/map_bwamem/{unit}.tsv"
    params:
        index=config['params']['bwa mem']['index'],
        extra=r"-R '@RG\tID:{unit}\tSM:{unit}'",
        sort=config['params']['bwa mem']['sort'],               # Can be 'none', 'samtools' or 'picard'.
        sort_order=config['params']['bwa mem']['sort_order'],   # Can be 'queryname' or 'coordinate'.
        sort_extra=config['params']['bwa mem']['sort_extra']    # Extra args for samtools/picard.
    threads:
        config['threads']['bwa mem']
    wrapper:
        "0.27.1/bio/bwa/mem"