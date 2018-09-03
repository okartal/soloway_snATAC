rule callpeak_macs2:
    input:
        "results/{unit}.bed.gz"
    output:
        "results/{unit}_peaks.narrowPeak",
        "results/{unit}_peaks.xls",
        "results/{unit}_summits.bed"
    log:
        "results/logs/callpeak_macs2/{unit}.log"
    benchmark:
        "results/benchmarks/callpeak_macs2/{unit}.log"
    params:
        config['params']['macs2 callpeak']
    conda:
        "../envs/snatac.yaml"
    shell:
        "macs2 callpeak -t {input} -n {wildcards.unit} {params} 2> {log}"