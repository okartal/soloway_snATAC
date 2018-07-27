rule map_scATAC:
    """Run scATAC to map single nucleus reads. 
    """
    input:
        r1="results/barcoded.{unit}.R1.fastq.gz",
        r2="results/barcoded.{unit}.R2.fastq.gz"
    output:
        "results/{unit}.bam"
    benchmark: "benchmarks/map_scATAC/{unit}.bam"
    log: "logs/map_scATAC/{unit}.log"
    threads: config['threads']['scATAC']
    params: config['params']['scATAC']
    shell:
        "scATAC"
        " -f {input.r1}"
        " -r {input.r2}"
        " -t {threads}"
        " -n {wildcards.unit}"
        " {params}"
        " > {log};"
        "mv $(basename -- '{output}') results/{output}"
