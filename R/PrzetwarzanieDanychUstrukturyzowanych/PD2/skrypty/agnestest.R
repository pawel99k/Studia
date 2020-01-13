#program w celu sprawdzenia która metoda funkcji agnes jest najbardziej skuteczna


test_bench_agnes <- function(dataset, label){
  
  require(abind)
  require(cluster)
  
  
  X <- dataset
  Y <- label
  Z <- dist(X)
  nofcluster <- max(Y)
  
  agnessingle <- agnes(Z, method = "single") %>% cutree(k=nofcluster)
  agnesaverage <- agnes(Z, method = "average") %>% cutree(k=nofcluster)
  agnescomplete <- agnes(Z, method = "complete") %>% cutree(k=nofcluster)
  agnesward <- agnes(Z, method = "ward") %>% cutree(k=nofcluster)
  agnesweighted <- agnes(Z, method = "weighted") %>% cutree(k=nofcluster)
  agnesgaverage <- agnes(Z, method = "gaverage") %>% cutree(k=nofcluster)
  
  
  
  matrix(cbind(
    mclust::adjustedRandIndex(agnessingle, Y[[1]]),      
    mclust::adjustedRandIndex(agnesaverage, Y[[1]]),      
    mclust::adjustedRandIndex(agnescomplete, Y[[1]]),      
    mclust::adjustedRandIndex(agnesward, Y[[1]]),      
    mclust::adjustedRandIndex(agnesweighted, Y[[1]]),
    mclust::adjustedRandIndex(agnesgaverage, Y[[1]])),     
    
         nrow=1) -> wynik
  
  matrix(cbind(dendextend::FM_index(agnessingle, Y[[1]])[1],
               dendextend::FM_index(agnesaverage, Y[[1]])[1],
               dendextend::FM_index(agnescomplete, Y[[1]])[1],
               dendextend::FM_index(agnesward, Y[[1]])[1],
               dendextend::FM_index(agnesweighted, Y[[1]])[1],
               dendextend::FM_index(agnesgaverage, Y[[1]])[1]),
               nrow=1) -> wynikFM
  
  non_scaled <- abind(wynik, wynikFM, along=3)
  print("non-scaled: done")
  
  #dalsza czesc funkcji jest powtorzeniem powyzszej - zostala stworzona w celu sprawdzenia skutecznosci analizy danych ustandaryzowanych
  
  X <- scale(X)
  Z <- dist(X)
  
  
  agnessingle <- agnes(Z, method = "single") %>% cutree(k=nofcluster)
  agnesaverage <- agnes(Z, method = "average") %>% cutree(k=nofcluster)
  agnescomplete <- agnes(Z, method = "complete") %>% cutree(k=nofcluster)
  agnesward <- agnes(Z, method = "ward") %>% cutree(k=nofcluster)
  agnesweighted <- agnes(Z, method = "weighted") %>% cutree(k=nofcluster)
  agnesgaverage <- agnes(Z, method = "gaverage") %>% cutree(k=nofcluster)
  
  
  
  matrix(cbind(
    mclust::adjustedRandIndex(agnessingle, Y[[1]]),      
    mclust::adjustedRandIndex(agnesaverage, Y[[1]]),      
    mclust::adjustedRandIndex(agnescomplete, Y[[1]]),      
    mclust::adjustedRandIndex(agnesward, Y[[1]]),      
    mclust::adjustedRandIndex(agnesweighted, Y[[1]]),       
    mclust::adjustedRandIndex(agnesgaverage, Y[[1]])),     
    
    nrow=1) -> wynik_scaled
  
  matrix(cbind(dendextend::FM_index(agnessingle, Y[[1]])[1],
               dendextend::FM_index(agnesaverage, Y[[1]])[1],
               dendextend::FM_index(agnescomplete, Y[[1]])[1],
               dendextend::FM_index(agnesward, Y[[1]])[1],
               dendextend::FM_index(agnesweighted, Y[[1]])[1],
               dendextend::FM_index(agnesgaverage, Y[[1]])[1]),
         nrow=1) -> wynik_scaled_FM
  
  scaled <- abind(wynik_scaled, wynik_scaled_FM, along=3)
  #
  abind(non_scaled, scaled, along=4) -> out
  
  attr(out, "dimnames")[[2]] <- c("Single", "Average", "Complete", "Ward", "Weighted", "GAverage")
  attr(out, "dimnames")[[3]] <- c("AR", "FM")
  attr(out, "dimnames")[[4]] <- c("non-scaled", "scaled")
  out
  
}

list.files(path="F://Projekt//graves", pattern = ".data") -> plikidata
list.files(path="F://Projekt//graves", pattern = ".labels") -> plikilabels

out <- matrix(rep(NA, 6), nrow = 1)
out <- abind(out, out, along=3)
out <- abind(out, out, along=4)
attr(out, "dimnames")[[2]] <- c("Single", "Average", "Complete", "Ward", "Weighted", "GAverage")
attr(out, "dimnames")[[3]] <- c("AR", "FM")
attr(out, "dimnames")[[4]] <- c("non-scaled", "scaled")

for(i in 1:length(plikidata)){
X <- read.csv(paste("F:/Projekt/graves/", plikidata[i], sep=""), header = F, sep = " ")
Y <- read.csv(paste("F:/Projekt/graves/", plikilabels[i], sep=""),  header = F, sep = " ")
abind(test_bench_agnes(X, Y), out, along=1) -> out
}

out[-7,,,] -> agnestest

sapply(split(agnestest, rep(1:6, each=6)), mean) -> agnesmeans
attr(agnesmeans, "names") <- c("Single", "Average", "Complete", "Ward", "Weighted", "GAverage")
agnesmeans
write.csv(agnesmeans, "agnestest.csv")

