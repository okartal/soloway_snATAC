rule cell_matrix:
    input:
        bam="results/{unit}_csorted.bam",
        bai="results/{unit}_csorted.bam.bai",
        ind="results/{unit}.xgi",
        bed="results/{unit}_peaks.narrowPeak"
    output:
        "results/{unit}.mat"
    benchmark:
        "results/benchmarks/cell_matrix/{unit}.tsv"
    params:
        all_sites = config['params']['cell matrix']['all sites']
    conda:
        "../envs/snatac.yaml"
    shell:
        "python ../scripts/sc_atac_window_counter.py"
        " {input.bam} {input.ind} {input.bed} {output}"
        " {params.all_sites}"