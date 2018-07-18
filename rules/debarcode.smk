rule debarcode:
    """Tag each insert read with the index reads.

    This rule uses a script from the epigen-UCSD/snATAC_pipeline in order to
    extract and combine the barcodes from the index reads and add the combined
    barcode to the sequence ID of each insert read.

    Note: Ensure that scATAC_debarcode is added to your path.
    """
    input:
        ind1="data/reads/{name}.I1.fastq.gz",
        ind2="data/reads/{name}.I2.fastq.gz",
        read="data/reads/{name}.{read}.fastq.gz"
    output:
        "results/barcoded.{name}.{read}.fastq.gz"
    benchmark:
        "benchmarks/debarcode/barcoded.{name}.{read}.tsv"
    shell:
        "python2.7 scATAC_debarcode"
        " -a {input.ind1}"
        " -b {input.ind2}"
        " -c {input.read}"
        " | gzip - > {output}"