rule map_scATAC:
    """Run scATAC to map single nucleus reads.

    We still use this instead of bwa mem since it implements error correction
    which the new snATAC pipeline has not implemented yet. 
    """
    input:
        r1="results/barcoded.{unit}.R1.fastq.gz",
        r2="results/barcoded.{unit}.R2.fastq.gz"
    output:
        "results/{unit}.bam"
    log:
        "results/logs/map_scATAC/{unit}.log"
    benchmark:
        "results/benchmarks/map_scATAC/{unit}.bam"
    threads:
        config['threads']['scATAC']
    params:
        config['params']['scATAC']
    conda:
        "../envs/snatac.yaml"
    shell:
        "scATAC -f {input.r1} -r {input.r2}"
        " -t {threads} -n {wildcards.unit} {params}"
        " > {log};"
        " mv $(basename -- '{output}') {output};"
        " rm {wildcards.unit}*log"
