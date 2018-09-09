rule qc_cells:
    input:
        promoters="data/mm10_consecutive_promoters.bed",
        promotercov="results/{unit}.promoter_cov",
        readcell="results/{unit}.reads_per_cell",
        readpeak="results/{unit}.reads_in_peak"
    output:
        xgi="results/{unit}.xgi"
    benchmark:
        "results/benchmarks/cell_selection/{unit}.tsv"
    params:
        min_frip = config['params']['cell selection']['minimum FRiP score'],
        min_read = config['params']['cell selection']['minimum reads per barcode']
    script:
        "../scripts/qc_cells.R"