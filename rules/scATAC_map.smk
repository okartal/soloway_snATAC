rule scATAC_map:
    """Run scATAC to map single nucleus reads. 
    """
    input:
        r1="results/barcoded.{unit}.R1.fastq.gz",
        r2="results/barcoded.{unit}.R2.fastq.gz"
    output:
        expand(
            "results/{{unit}}_tmp/{{unit}}.umap.{suf}",
            suf=['bam', 'corrected.bam', 'corrected.nsorted.bam']
            )
    # benchmark: "benchmarks/scATAC/"
    log: "logs/scATAC_map/{unit}.log"
    threads: config['threads']['scATAC']
    params: config['params']['scATAC']
    shell:
        "scATAC"
        " -f {input.r1}"
        " -r {input.r2}"
        " -t {threads}"
        " -n results/{wildcards.unit}"
        " {params}"
        " > {log}"