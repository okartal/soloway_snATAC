rule scATAC_debarcode:
    """Tag each insert read with the index reads.

    This rule uses a script from the epigen-UCSD/snATAC_pipeline in order to
    extract and combine the barcodes from the index reads and add the combined
    barcode to the sequence ID of each insert read.
    """
    input:
        ind1="data/reads/{unit}.I1.fastq.gz",
        ind2="data/reads/{unit}.I2.fastq.gz",
        read="data/reads/{unit}.{read}.fastq.gz"
    output:
        "results/barcoded.{unit}.{read}.fastq.gz"
    # benchmark: "benchmarks/debarcode/barcoded.{unit}.{read}.tsv"
    shell:
        "scATAC_debarcode"
        " -a {input.ind1}"
        " -b {input.ind2}"
        " -c {input.read}"
        " | gzip - > {output}"