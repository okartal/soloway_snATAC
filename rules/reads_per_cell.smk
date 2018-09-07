rule reads_per_cell:
    input:
        "results/{unit}.bed.gz"
    output:
        "results/{unit}.reads_per_cell"
    benchmark:
        "results/benchmarks/reads_per_cell/{unit}.reads_per_cell.tsv"
    shell:
        "gzip -cd {input}"
        " | cut -f4 | sort | uniq -c"
        " | awk '{{ print $2, $1 }}'"
        " | sort -k1,1"
        " > {output}"