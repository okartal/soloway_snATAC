# snATAC tsne plot
##################################################################
# Dimentionality reduction using t-SNE
# Please refer to https://lvdmaaten.github.io/tsne/ for how to
# tune parameters such as perplexity. We find most of time, it 
# takes less than 500 iteration to converge.
##################################################################
# need to visualize : test_ATAC.p56peak.jacard, test_ATAC_distal.p56peak.jacard
#                     p56.rep1.jacard, p56.rep1_refSeq_distal.jacard
#                     combined.jacard, combined_distal.jacard

setwd("e:/Soloway/sciATAC/")

library(tsne)
#library(Rtsne)

dist <- as.matrix(read.table("fly/2kb.no_ConstPromFiltering.jacard"))
diag(dist) <- 0


dist_tsne = tsne(dist/sum(dist),initial_config = NULL, 
                 k = 3, perplexity = 30, max_iter = 1000, 
                 min_cost = 0, epoch_callback = NULL, 
                 whiten = TRUE, epoch=100)


library(scatterplot3d)
par(mfrow=c(1,2))
plot(dist_tsne, cex=0.7, xlab="tsne1", ylab="tsne2")
scatterplot3d(x=dist_tsne[,1],y=dist_tsne[,2],z=dist_tsne[,3])


write.table(dist_tsne, file = "2kb.tsne", append = FALSE, 
            quote = FALSE, sep = "\t", eol = "\n", 
            na = "NA", dec = ".", row.names = FALSE,
            col.names = FALSE, qmethod = c("escape", "double"),
            fileEncoding = "")



##################################################################
# NOTE: Choosing cluster number is absolutely an art! In our paper, 
# we adopted a method originally published from Habib et al. that
# determines the best cluster number by optimizing Dunn Index.
# However, such approach is extremely slow with time complexity
# O(n^3), without optimization and better implementation, it is
# almost impossible to run on a sample of thousands of cells.
# Therefore, we decided to switch to a heuristic approach as shown
# below. Though, it does not guarantee the best result (in fact, 
# none of the methods do), from our experience, it gives satisfactory
# result. At the end of the day, choosing the optimal cluster number
# is very tricky task and it is hard to be fully automatic. We still
# post our code for Dunn Index approach as described in our paper. 
##################################################################

library(densityClust)

MaxStep <- function(D){
  D_hat <- D
  n = nrow(D)
  for(k in 1:n){
    for(i in 1:(n-1)){
      for(j in (i+1):n){
        D_hat[i,j] <- min(D_hat[i,j], 
                          max(D_hat[k,j], D_hat[i,k]))
      }
    }
  }
  return(D_hat)
}
find_center <- function(p, clust){
  centers <- data.frame()
  cols <- c()
  for(i in as.numeric(names(table(clust)))){
    ind <- which(clust== i)
    if(length(ind) > 10){
      centers <- rbind(centers, colMeans(p[ind,1:3]))
      cols <- c(cols, i)
    }
  }
  res <- cbind(centers, cols)
  colnames(res) <- c("x", "y", "z", "col")
  return(res)
}
DB_index <- function(D, CL){
  cl_uniq <- unique(CL)
  n <- length(cl_uniq)
  d_k <- rep(0, n)
  d_ij <- matrix(0, n, n)
  for(i in 1:n){
    ii <- which(CL == i);
    d_k[i] <- max(MaxStep(D[ii,ii]))
  }
  for(i in 1:(n-1)){
    for(j in (i+1):n){
      ii <- which(CL == i | CL == j)
      d_ij <- max(MaxStep(D[ii,ii]))
    }
  }
  return(min(d_ij)/max(d_k))
}

# perform cluster
points_dist <- read.table("2kb.tsne")
#points_prox<-prox_tsne
points_dist<-dist_tsne

set.seed(10)
dis <- dist(points_dist)
irisClust <- densityClust(dis, gaussian=TRUE)

# plot decision graph
#plot(irisClust)

rho_cutoff <- irisClust$dc
delta_cutoff <- 25
irisClust <- findClusters(irisClust, 
                          rho= rho_cutoff, 
                          delta= delta_cutoff)

clusters <- irisClust$cluster

barcodes <- read.table("2kb.no_ConstPromFiltering.xgi")
clusters[which(apply(barcodes, 1, function(x) any(grepl("our", x))))] <- -clusters[which(apply(barcodes, 1, function(x) any(grepl("our", x))))]
unique <- !duplicated(clusters)
plot(points_dist, col=ifelse(clusters < 0, 'orange', clusters), pch=19, cex=0.7)

dev.off()

scatterplot3d(points_dist[,1:3], color=ifelse(clusters < 0, 'orange', clusters), pch=19)

par(mfrow=c(2,2)) 
s3d <- scatterplot3d(points_dist[,1:3], color=ifelse(clusters < 0,'orange', clusters), pch=20, box = FALSE, angle = 0)
text(s3d$xyz.convert(points_dist[unique,1:3]), labels = clusters[unique], cex= 0.7, col = "steelblue",pos = 4)
s3d <- scatterplot3d(points_dist[,1:3], color=ifelse(clusters < 0,'orange', clusters), pch=20, box = FALSE, angle = 90)
text(s3d$xyz.convert(points_dist[unique,1:3]), labels = clusters[unique], cex= 0.7, col = "steelblue",pos = 4)
s3d <- scatterplot3d(points_dist[,1:3], color=ifelse(clusters < 0,'orange', clusters), pch=20, box = FALSE, angle = 180)
text(s3d$xyz.convert(points_dist[unique,1:3]), labels = clusters[unique], cex= 0.7, col = "steelblue",pos = 4)
s3d <- scatterplot3d(points_dist[,1:3], color=ifelse(clusters < 0,'orange', clusters), pch=20, box = FALSE, angle = 270)
text(s3d$xyz.convert(points_dist[unique,1:3]), labels = clusters[unique], cex= 0.7, col = "steelblue",pos = 4)

dev.off()


write.table(data.frame(clusters), file = "2kb.noCPfiltering.cluster",
            append = FALSE, quote = FALSE, sep = "\t",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = FALSE, qmethod = c("escape", "double"),
            fileEncoding = "")
