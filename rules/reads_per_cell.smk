rule reads_per_cell:
    input:
        "results/{unit}.bed.gz"
    output:
        "results/{unit}_reads-per-cell.csv"
    benchmark:
        "results/benchmarks/reads_per_cell/{unit}_reads-per-cell.tsv"
    shell:
        "gzip -cd {input}"
        " | cut -f4 | sort | uniq -c"
        " | awk '{{OFS=\",\";}} {{ print $2, $1 }}'"
        " > {output}"