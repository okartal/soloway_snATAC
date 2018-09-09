# cell_selection.R
#
# Quality control of cells by number of reads and FRiP score.
#
# Follows the R script from https://github.com/r3fang/snATAC.git

consecutive_promoters <- read.table(snakemake@input[["promoters"]])
promoter_cov <- read.table(snakemake@input[["promotercov"]])
num_of_reads <- read.table(snakemake@input[["readcell"]])
read_in_peak <- read.table(snakemake@input[["readpeak"]])

min_frip <- snakemake@params[["min_frip"]]
min_read <- snakemake@params[["min_read"]]

qc = num_of_reads; 
colnames(qc) <- c("barcode", "num_of_reads")
qc$promoter_cov = 0; 
qc$read_in_peak = 0;
qc$promoter_cov[match(promoter_cov$V1, qc$barcode)] = promoter_cov$V2/nrow(consecutive_promoters)
qc$read_in_peak[match(read_in_peak$V1, qc$barcode)] = read_in_peak$V2
qc$ratio = qc$read_in_peak/qc$num_of_reads
idx <- which(qc$ratio > min_frip & qc$num_of_reads > min_read)
qc_sel <- qc[idx,]

write.table(
    qc_sel[,1],
    file = snakemake@output[["xgi"]],
    append = FALSE,
    quote = FALSE,
    sep = "\t",
    eol = "\n", 
    na = "NA",
    dec = ".",
    row.names = FALSE,
    col.names = FALSE,
    qmethod = c("escape", "double"),
    fileEncoding = "")
