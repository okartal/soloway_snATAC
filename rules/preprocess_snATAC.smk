rule preprocess_snATAC:
    input: "{unit}.bam"
    output: "results/{unit}.bed.gz"
    log: "logs/preprocess_snATAC/{unit}.log"
    params: config['params']['snATAC pre']
    threads: config['threads']['snATAC pre']
    shell:
        "snATAC pre -t {threads} {params}"
        " -i {input} -o {output}"
        " 2> {log}"