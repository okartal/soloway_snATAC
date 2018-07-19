rule map_scATAC:
    """Run scATAC to map single nucleus reads. 
    """
    input:
        r1="results/barcoded.{unit}.R1.fastq.gz",
        r2="results/barcoded.{unit}.R2.fastq.gz"
    output:
        "{unit}.bam"
    benchmark: "benchmarks/map_scATAC/{unit}.bam"
    log: "logs/map_scATAC/{unit}.log"
    threads: config['threads']['scATAC']
    params: config['params']['scATAC']
    shell:
        "scATAC"
        " -f {input.r1}"
        " -r {input.r2}"
        " -t {threads}"
        " -n {wildcards.unit}"
        " {params}"
        " > {log}"

# Note: This rule only works after some corrections to scATAC, see this diff output:
# diff --git a/bin/scATAC b/bin/scATAC
# index dd246a1..77e2ddb 100755
# --- a/bin/scATAC
# +++ b/bin/scATAC
# @@ -197,7 +197,7 @@ do
#           done
#      fi
#  done
# -rm -r $PREFIX\_tmp/cells/*_tmp
# +#rm -r $PREFIX\_tmp/cells/*_tmp
#  rm $PREFIX\_tmp/cells/*.sam
 
#  echo " (`date`) Step 5. merge reads from different cells to a single file;" 2>&1 | tee -a $PREFIX.log
# @@ -216,7 +216,7 @@ samtools view -h $PREFIX\_tmp/$PREFIX.umap.corrected.nsorted.nodup.bam \
#  | samtools view -bS - > $PREFIX\_tmp/$PREFIX.umap.corrected.nsorted.nodup.filtered.bam
 
#  echo " (`date`) Step 8. sort by genomic coordinates;" 2>&1 | tee -a $PREFIX.log
# -samtools sort -@ $THREADS -m 1G $PREFIX\_tmp/$PREFIX.umap.corrected.nsorted.nodup.filtered.bam -o $PREFIX\_tmp/$PREFIX.umap.corrected.nsorted.nodup.filtered.gsorted
# +samtools sort -@ $THREADS -m 1G $PREFIX\_tmp/$PREFIX.umap.corrected.nsorted.nodup.filtered.bam -o $PREFIX\_tmp/$PREFIX.umap.corrected.nsorted.nodup.filtered.gsorted.bam
 
#  echo " (`date`) Step 9. summerize;" 2>&1 | tee -a $PREFIX.log
#  TOTAL_READS=$(zcat $R1 | wc -l | awk '{print $1}')
# @@ -253,4 +253,4 @@ END{
#      print "Max number of reads for selected cells: "max(a)
#  }' 2>&1 | tee -a $PREFIX.log
#  mv $PREFIX\_tmp/$PREFIX.umap.corrected.nsorted.nodup.filtered.gsorted.bam $PREFIX.bam
# -#rm -r $PREFIX\_tmp
# +rm -r $PREFIX\_tmp
