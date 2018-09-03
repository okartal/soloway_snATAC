rule preprocess_snATAC:
    input:
        "results/{unit}_nsorted.bam"
    output:
        "results/{unit}.bed.gz"
    log:
        "results/logs/preprocess_snATAC/{unit}.log"
    benchmark:
        "results/benchmarks/preprocess_snATAC/{unit}.log"
    params:
        config['params']['snATAC pre']
    threads:
        config['threads']['snATAC pre']
    conda:
        "../envs/snatac.yaml"
    shell:
        "snATAC pre -i {input} -o {output}"
        " -t {threads} {params} 2> {log}"