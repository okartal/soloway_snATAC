rule bedtools_promotercov:
    input:
        reads="results/{unit}.bed.gz",
        promoters="data/mm10_consecutive_promoters.bed"
    output:
        "results/{unit}.promoter_cov"
    benchmark:
        "results/benchmarks/bedtools_promotercov/{unit}.promoter-cov.tsv"
    conda:
        "../envs/snatac.yaml"
    shell:
     "bedtools intersect -wa -wb"
     " -a {input.reads}"
     " -b {input.promoters}"
     " | cut -f4,8"
     " | sort"
     " | uniq" 
     " | cut -f1"
     " | uniq -c"
     " | awk '{{print $2, $1}}'"
     " | sort -k1,1"
     " > {output}"