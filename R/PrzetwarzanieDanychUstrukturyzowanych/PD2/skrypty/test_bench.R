#Funkcja do testowanaia algorytmów klasteryzacji oraz stworzenie pliku csv

test_bench <- function(dataset, label){
  
  require(genie)
  require(igraph)
  require(abind)
  require(cluster)
  
  
  X <- dataset
  Y <- label
  Z <- dist(X)
  nofcluster <- max(Y)
  

  mcomplete <- hclust(Z) %>% cutree(k=nofcluster)
  
  mwardD <- hclust(Z, method="ward.D") %>% cutree(k=nofcluster)
  
  mwardD2 <- hclust(Z, method = "ward.D2") %>% cutree(k=nofcluster)
  
  msingle <- hclust(Z, method = "single") %>% cutree(k=nofcluster)
  
  maverage <- hclust(Z, method = "average") %>% cutree(k=nofcluster)
  
  mmcquitty <- hclust(Z, method = "mcquitty") %>% cutree(k=nofcluster)
  
  mmedian <- hclust(Z, method = "median") %>% cutree(k=nofcluster)
 
  mcentroid <- hclust(Z, method = "centroid") %>% cutree(k=nofcluster)
  
  print("hclust")
  
  #metoda "Single" funkcji agnes charakteryzowała się zarówno największa skutecznością, jak i jednym z najkrótszych czasów działania
  agnessingle <- agnes(Z, method = "single") %>% cutree(k=nofcluster)
  
  print("agnes")
  
  mgenie <- hclust2(Z) %>% cutree(k=nofcluster)
  mgenie2 <- hclust2(Z, thresholdGini = 0.2) %>% cutree(k=nofcluster)
  mgenie4 <- hclust2(Z, thresholdGini = 0.4) %>% cutree(k=nofcluster)
  mgenie5 <- hclust2(Z, thresholdGini = 0.5) %>% cutree(k=nofcluster)
  mgenie6 <- hclust2(Z, thresholdGini = 0.6) %>% cutree(k=nofcluster)
  mgenie7 <- hclust2(Z, thresholdGini = 0.7) %>% cutree(k=nofcluster)
  print("genie")
  
  own1q <- spectral_clustering(X, nofcluster, round(nrow(X)*0.25))$cluster
  
  own2q <- spectral_clustering(X, nofcluster, round(nrow(X)*0.5))$cluster
  
  own3q <- spectral_clustering(X, nofcluster, round(nrow(X)*0.75))$cluster
  
  own5 <- spectral_clustering(X, nofcluster, 5)$cluster
  
  own10 <- spectral_clustering(X, nofcluster, 10)$cluster
  
  own12 <- spectral_clustering(X, nofcluster, 12)$cluster
  
  own15 <- spectral_clustering(X, nofcluster, 15)$cluster
  
  own <- spectral_clustering(X, nofcluster, round(nrow(X)/nofcluster))$cluster
  print("own")
  matrix(cbind(mclust::adjustedRandIndex(mcomplete, Y[[1]]),
                     mclust::adjustedRandIndex(mwardD, Y[[1]]),
                     mclust::adjustedRandIndex(mwardD2, Y[[1]]),
                     mclust::adjustedRandIndex(msingle, Y[[1]]),
                     mclust::adjustedRandIndex(maverage, Y[[1]]),
                     mclust::adjustedRandIndex(mmcquitty, Y[[1]]),
                     mclust::adjustedRandIndex(mmedian, Y[[1]]),
                     mclust::adjustedRandIndex(mcentroid, Y[[1]]),
                     mclust::adjustedRandIndex(mgenie, Y[[1]]),
                     mclust::adjustedRandIndex(mgenie2, Y[[1]]),
                     mclust::adjustedRandIndex(mgenie4, Y[[1]]),
                     mclust::adjustedRandIndex(mgenie5, Y[[1]]),
                     mclust::adjustedRandIndex(mgenie6, Y[[1]]),
                     mclust::adjustedRandIndex(mgenie7, Y[[1]]),
                     mclust::adjustedRandIndex(agnessingle, Y[[1]]),      
                     mclust::adjustedRandIndex(own1q, Y[[1]]),
                     mclust::adjustedRandIndex(own2q, Y[[1]]),
                     mclust::adjustedRandIndex(own3q, Y[[1]]),
                     mclust::adjustedRandIndex(own5, Y[[1]]),
                     mclust::adjustedRandIndex(own10, Y[[1]]),
                     mclust::adjustedRandIndex(own12, Y[[1]]),
                     mclust::adjustedRandIndex(own15, Y[[1]]),
                     mclust::adjustedRandIndex(own, Y[[1]])),
                     nrow=1) -> wynik
  
  matrix(cbind(dendextend::FM_index(mcomplete, Y[[1]])[1],
               dendextend::FM_index(mwardD, Y[[1]])[1],
               dendextend::FM_index(mwardD2, Y[[1]])[1],
               dendextend::FM_index(msingle, Y[[1]])[1],
               dendextend::FM_index(maverage, Y[[1]])[1],
               dendextend::FM_index(mmcquitty, Y[[1]])[1],
               dendextend::FM_index(mmedian, Y[[1]])[1],
               dendextend::FM_index(mcentroid, Y[[1]])[1],
               dendextend::FM_index(mgenie, Y[[1]])[1],
               dendextend::FM_index(mgenie2, Y[[1]])[1],
               dendextend::FM_index(mgenie4, Y[[1]])[1],
               dendextend::FM_index(mgenie5, Y[[1]])[1],
               dendextend::FM_index(mgenie6, Y[[1]])[1],
               dendextend::FM_index(mgenie7, Y[[1]])[1],
               dendextend::FM_index(agnessingle, Y[[1]])[1],
               dendextend::FM_index(own1q, Y[[1]])[1],
               dendextend::FM_index(own2q, Y[[1]])[1],
               dendextend::FM_index(own3q, Y[[1]])[1],
               dendextend::FM_index(own5, Y[[1]])[1],
               dendextend::FM_index(own10, Y[[1]])[1],
               dendextend::FM_index(own12, Y[[1]])[1],
               dendextend::FM_index(own15, Y[[1]])[1],
               dendextend::FM_index(own, Y[[1]])[1]), nrow=1) -> wynikFM
  
  non_scaled <- abind(wynik, wynikFM, along=3)
  print("non-scaled: done")
  
  #dalsza czesc funkcji jest powtorzeniem powyzszej - zostala stworzona w celu sprawdzenia skutecznosci analizy danych ustandaryzowanych
  
  X <- scale(X)
  Z <- dist(X)
  
  mcomplete <- hclust(Z)%>% cutree(k=nofcluster)
  
  mwardD <- hclust(Z, method="ward.D")%>% cutree(k=nofcluster)
  
  mwardD2 <- hclust(Z, method = "ward.D2")%>% cutree(k=nofcluster)
  
  msingle <- hclust(Z, method = "single")%>% cutree(k=nofcluster)
  
  maverage <- hclust(Z, method = "average")%>% cutree(k=nofcluster)
  
  mmcquitty <- hclust(Z, method = "mcquitty")%>% cutree(k=nofcluster)
  
  mmedian <- hclust(Z, method = "median")%>% cutree(k=nofcluster)
  
  mcentroid <- hclust(Z, method = "centroid")%>% cutree(k=nofcluster)
  
  mgenie <- hclust2(Z)%>% cutree(k=nofcluster)
  mgenie2 <- hclust2(Z, thresholdGini = 0.2) %>% cutree(k=nofcluster)
  mgenie4 <- hclust2(Z, thresholdGini = 0.4) %>% cutree(k=nofcluster)
  mgenie5 <- hclust2(Z, thresholdGini = 0.5) %>% cutree(k=nofcluster)
  mgenie6 <- hclust2(Z, thresholdGini = 0.6) %>% cutree(k=nofcluster)
  mgenie7 <- hclust2(Z, thresholdGini = 0.7) %>% cutree(k=nofcluster)
  
  agnessingle <- agnes(Z, method = "single")%>% cutree(k=nofcluster)
  
  mgenie <- hclust2(Z)%>% cutree(k=nofcluster)
  
  own1q <- spectral_clustering(X, nofcluster, round(nrow(X)*0.25))$cluster

  own2q <- spectral_clustering(X, nofcluster, round(nrow(X)*0.5))$cluster
  
  own3q <- spectral_clustering(X, nofcluster, round(nrow(X)*0.75))$cluster
  
  own5 <- spectral_clustering(X, nofcluster, 5)$cluster
  
  own10 <- spectral_clustering(X, nofcluster, 10)$cluster
  
  own12 <- spectral_clustering(X, nofcluster, 12)$cluster
  
  own15 <- spectral_clustering(X, nofcluster, 15)$cluster
  
  own <- spectral_clustering(X, nofcluster, round(nrow(X)/nofcluster))$cluster
  print("end")
  matrix(cbind(mclust::adjustedRandIndex(mcomplete, Y[[1]]),
               mclust::adjustedRandIndex(mwardD, Y[[1]]),
               mclust::adjustedRandIndex(mwardD2, Y[[1]]),
               mclust::adjustedRandIndex(msingle, Y[[1]]),
               mclust::adjustedRandIndex(maverage, Y[[1]]),
               mclust::adjustedRandIndex(mmcquitty, Y[[1]]),
               mclust::adjustedRandIndex(mmedian, Y[[1]]),
               mclust::adjustedRandIndex(mcentroid, Y[[1]]),
               mclust::adjustedRandIndex(mgenie, Y[[1]]),
               mclust::adjustedRandIndex(mgenie2, Y[[1]]),
               mclust::adjustedRandIndex(mgenie4, Y[[1]]),
               mclust::adjustedRandIndex(mgenie5, Y[[1]]),
               mclust::adjustedRandIndex(mgenie6, Y[[1]]),
               mclust::adjustedRandIndex(mgenie7, Y[[1]]),
               mclust::adjustedRandIndex(agnessingle, Y[[1]]),     
               mclust::adjustedRandIndex(own1q, Y[[1]]),
               mclust::adjustedRandIndex(own2q, Y[[1]]),
               mclust::adjustedRandIndex(own3q, Y[[1]]),
               mclust::adjustedRandIndex(own5, Y[[1]]),
               mclust::adjustedRandIndex(own10, Y[[1]]),
               mclust::adjustedRandIndex(own12, Y[[1]]),
               mclust::adjustedRandIndex(own15, Y[[1]]),
               mclust::adjustedRandIndex(own, Y[[1]])),
               nrow=1) -> wynik_scaled
  matrix(cbind(dendextend::FM_index(mcomplete, Y[[1]])[1],
               dendextend::FM_index(mwardD, Y[[1]])[1],
               dendextend::FM_index(mwardD2, Y[[1]])[1],
               dendextend::FM_index(msingle, Y[[1]])[1],
               dendextend::FM_index(maverage, Y[[1]])[1],
               dendextend::FM_index(mmcquitty, Y[[1]])[1],
               dendextend::FM_index(mmedian, Y[[1]])[1],
               dendextend::FM_index(mcentroid, Y[[1]])[1],
               dendextend::FM_index(mgenie, Y[[1]])[1],
               dendextend::FM_index(mgenie2, Y[[1]])[1],
               dendextend::FM_index(mgenie4, Y[[1]])[1],
               dendextend::FM_index(mgenie5, Y[[1]])[1],
               dendextend::FM_index(mgenie6, Y[[1]])[1],
               dendextend::FM_index(mgenie7, Y[[1]])[1],
               dendextend::FM_index(agnessingle, Y[[1]])[1],
               dendextend::FM_index(own1q, Y[[1]])[1],
               dendextend::FM_index(own2q, Y[[1]])[1],
               dendextend::FM_index(own3q, Y[[1]])[1],
               dendextend::FM_index(own5, Y[[1]])[1],
               dendextend::FM_index(own10, Y[[1]])[1],
               dendextend::FM_index(own12, Y[[1]])[1],
               dendextend::FM_index(own15, Y[[1]])[1],
               dendextend::FM_index(own, Y[[1]])[1]), nrow=1) -> wynik_scaled_FM
  
  scaled <- abind(wynik_scaled, wynik_scaled_FM, along=3)
  #
  abind(non_scaled, scaled, along=4) -> out

  attr(out, "dimnames")[[2]] <- c("HComplete", "HWardD", "HWardD2", "HSingle", "HAverage", "HMcQuitty", "HMedian", "HCentroid", "Genie",
                                  "Genie0.2", "Genie0.4", "Genie0.5", "Genie0.6", "Genie0.7", "ASingle", "ownq1", "own2q",
                                  "own3q", "own5", "own10", "own12", "own15", "own")
  attr(out, "dimnames")[[3]] <- c("AR", "FM")
  attr(out, "dimnames")[[4]] <- c("non-scaled", "scaled")
  out
  
}

aa1<- test_bench(atom, atom.l)
aa2 <- test_bench(chainlink, chainlink.l)
aa3 <- test_bench(engytime, engytime.l)
aa4 <- test_bench(hepta, hepta.l)
aa5 <- test_bench(lsun, lsun.l)
aa6 <- test_bench(target, target.l)
aa7 <- test_bench(tetra, tetra.l)
aa8 <- test_bench(twodiamonds, twodiamonds.l)
aa9 <- test_bench(wingnut, wingnut.l)

b1 <- test_bench(dense, dense.l)
b2 <- test_bench(fuzzyx, fuzzyx.l)
b3 <- test_bench(line, line.l)
b4 <- test_bench(parabolic, parabolic.l)
b5 <- test_bench(ring, ring.l)
b6 <- test_bench(zigzag, zigzag.l)

c1 <- test_bench(iris, iris.l)
c2 <- test_bench(iris5, iris5.l)
c3 <- test_bench(square, square.l)

d1 <- test_bench(a1, a1.l)
d2 <- test_bench(a2, a2.l)
d3 <- test_bench(a3, a3.l)###
d4 <- test_bench(aggregation, aggregation.l)
d5 <- test_bench(compound, compound.l)
d6 <- test_bench(d31, d31.l)
d7 <- test_bench(flame, flame.l)
d8 <- test_bench(jain, jain.l)
d9 <- test_bench(pathbased, pathbased.l)
d10 <- test_bench(r15, r15.l)
d11 <- test_bench(s1, s1.l)
d12 <- test_bench(s2, s2.l)
d13 <- test_bench(s3, s3.l)
d14 <- test_bench(s4, s4.l)
d15 <- test_bench(spiral, spiral.l)
d16 <- test_bench(unbalance, unbalance.l)###

e1 <- test_bench(cross, cross.l)
e2 <- test_bench(smile, smile.l)
e3 <- test_bench(twosplashes, twosplashes.l)
e4 <- test_bench(x1, x1.l)
e5 <- test_bench(x2, x2.l)
e6 <- test_bench(x3, x3.l)
e7 <- test_bench(z1, z1.l)
e8 <- test_bench(z2, z2.l)
e9 <- test_bench(z3, z3.l)##


f2 <- test_bench(benchmark2, benchmark2.l)
f3 <- test_bench(benchmark3, benchmark3.l)
f4 <- test_bench(benchmark4, benchmark4.l)



abind(aa1, aa2, aa3, aa4, aa5, aa6, aa7, aa8, aa9, along=1) -> fcps
rownames(fcps) <- c("atom", "chainlink", "engytime", "hepta", "lsun", "target", "tetra", "twodiamonds", "wingnut")

abind(b1, b2, b3, b4, b5, b6, along=1) -> graves
rownames(graves) <- c("dense", "fuzzyx", "line", "parabolic", "ring", "zigzag")

abind(c1, c2, c3, along=1) -> other
rownames(other) <- c("iris", "iris5", "square")


abind(d1, d2, d3, d4, d5, d6,  d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, along=1) -> sipu
rownames(sipu) <- c("a1", "a2", "a3", "aggregation", "compound", "d31", "flame", "jain", "pathbased", "r15", "s1", "s2",
                    "s3", "s4", "spiral", "unbalance")


abind(e1, e2, e3, e4, e5, e6, e7, e8, e9, along=1) -> wut
rownames(wut) <- c("cross", "smile", "twosplashes", "x1", "x2", "x3", "z1", "z2", "z3")


abind(f2, f3, f4, along = 1) -> mine
rownames(mine) <- c("benchmark2", "benchmark3", "benchmark4")


abind(fcps, graves, other, sipu, wut, mine, along=1) -> final

round(final, 5) -> nicefinal
write.csv(nicefinal, "nicefinal.csv")


## istotne
nicefinalcsv[44:46,] -> mine
write.csv(mine, "mine.csv")
##

options(stringsAsFactors = FALSE)
read.csv("nicefinal.csv") -> nicefinalcsv
rownames(nicefinalcsv) <- nicefinalcsv[,1]
nicefinalcsv <- nicefinalcsv[,-1]




