rule callpeak_macs2:
    input: "results/{unit}.bed.gz"
    output:
        "results/{unit}_peaks.narrowPeak",
        "results/{unit}_peaks.xls",
        "results/{unit}_summits.bed"
    log:
        "logs/callpeak_macs2/{unit}.log"
    params: config['params']['macs2 callpeak']
    shell:
        "macs2 callpeak -t {input} -n {wildcards.unit} {params}"
        "2> {log}"