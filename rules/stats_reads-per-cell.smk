rule stats_reads_per_cell:
    input:
        "results/{unit}.bed.gz"
    output:
        "results/{unit}.reads_per_cell"
    benchmark:
        "results/benchmarks/stats_reads-per-cell/{unit}.tsv"
    shell:
        "gzip -cd {input}"
        " | cut -f4 | sort | uniq -c"
        " | awk '{{ print $2, $1 }}'"
        " | sort -k1,1"
        " > {output}"