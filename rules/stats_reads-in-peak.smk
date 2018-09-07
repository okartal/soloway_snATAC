rule stats_reads_in_peak:
    input:
        reads="results/{unit}.bed.gz",
        peaks="results/{unit}_peaks.narrowPeak"
    output:
        "results/{unit}.reads_in_peak"
    benchmark:
        "results/benchmarks/stats_reads-in-peak/{unit}.tsv"
    conda:
        "../envs/snatac.yaml"
    shell:
        "bedtools intersect"
        " -a {input.reads} -b {input.peaks} -u"
        " | cut -f4 | sort | uniq -c"
        " | awk '{{print $2, $1}}'"
        " | sort -k1,1 > {output}"