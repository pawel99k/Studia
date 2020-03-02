#1. zbiór "benchmark2"


MFData <- function(n, theta, cluster, scale=1) {
  require(movMF)
  data <- rmovMF(n, theta)
  data <- data.frame(data[,1], data[,2]) 
  data <- data * scale
  colnames(data) <- c("V1", "V2")
  data[,3] <- rep(cluster, nrow(data))
  data
}

data1 <- generateMFData(200, 0.2 * c(-1, 1), 1, 5)
data2 <- generateMFData(100, 3 * c(1, -1), 2, 1)
data3 <- generateMFData(300, 0.6 * c(-1, 1), 3, 10)
prebenchmark2 <- rbind(data1, data2, data3)
benchmark2 <- prebenchmark2[,1:2]
benchmark2.l <- data.frame(as.double(prebenchmark2[,3]))
colnames(benchmark2) <- c("V1", "V2")



maluj(benchmark2, benchmark2.l)
spectral_clustering(benchmark2, max(benchmark2.l), round(nrow(benchmark2)/max(benchmark2.l)))$cluster -> benchmark2.my.labels
maluj(benchmark2, benchmark2.my.labels)
maluj(benchmark2, hclust(dist(benchmark2), method = "single") %>% cutree(k=max(benchmark2.l)))

#2. zbiór "benchmark3"

kostka <- cbind(runif(800, -1, 1), runif(800, -1, 1), runif(800, -1, 1))
kostka <- data.frame(kostka)
colnames(kostka) <- c("V1", "V2", "V3")

kostka[sqrt(kostka[,1]**2+kostka[,2]**2+kostka[,3]**2)>0.9,] -> obramowanie


malakostka <- cbind(runif(300, -0.3, 0.3), runif(300, -0.3, 0.3), runif(300, -0.3, 0.3))
malakostka <- data.frame(malakostka)
colnames(malakostka) <- c("V1", "V2", "V3")
benchmark3 <- rbind(malakostka, obramowanie)

plot_ly(benchmark3, x = ~V1, y = ~V2, z = ~V3 ) %>%
  add_markers()
benchmark3.l <- data.frame(c(rep(1, 300), rep(2, nrow(benchmark3)-300)))
maluj(benchmark3, benchmark3.l)
maluj(benchmark3, hclust(dist(benchmark3), method = "ward.D2") %>% cutree(k=2))

#3. zbiór "benchmark4"


I <- cbind(runif(300, 0, 1), runif(300, 0, 4))
kropka <- cbind(runif(100, 1.5, 2.5), runif(100, 3, 4))
kropka[sqrt((kropka[,1]-2)**2+(kropka[,2]-3.5)**2)<0.5,] -> kropka
i <- cbind(runif(200, 1.5, 2.5), runif(200, 0, 2))
a01 <- cbind(runif(400, 3, 5), runif(400, 0, 2))
a01[sqrt((a01[,1]-4)**2+(a01[,2]-1)**2)<1 & sqrt((a01[,1]-4)**2+(a01[,2]-1)**2)>0.6,] -> a01
a02 <- cbind(runif(200, 4.5, 5), runif(200, 0, 2.2))
a <- rbind(a01, a02)

d01 <- cbind(runif(400, 5.5, 7.5), runif(400, 0, 2))
d01[sqrt((d01[,1]-6.5)**2+(d01[,2]-1)**2)<1 & sqrt((d01[,1]-6.5)**2+(d01[,2]-1)**2)>0.6,] -> d01
d02 <- cbind(runif(400, 7, 7.5), runif(400, 0, 4))
d <- rbind(d01, d02)


rbind(I, i, kropka, a, d) -> Iiad
benchmark4 <- data.frame(Iiad)
colnames(benchmark4) <- c("V1","V2")
benchmark4.l <- data.frame(c(rep(1, 300), rep(2, 200), rep(3, 74), rep(4, 392), rep(5, 594)))

maluj(benchmark4, benchmark4.l)
maluj(benchmark4, hclust(dist(benchmark4), method = "single") %>% cutree(k=max(benchmark4.l)))


write(benchmark1.l[[1]], "benchmark1.labels0", ncolumns = 1)
write(as.matrix(benchmark1), "benchmark1.data", ncolumns = 2)
write(benchmark2.l[[1]], "benchmark2.labels0", ncolumns = 1)
write(as.matrix(benchmark2), "benchmark2.data", ncolumns = 2)
write(benchmark3.l[[1]], "benchmark3.labels0", ncolumns = 1)
write(as.matrix(benchmark3), "benchmark3.data", ncolumns = 3)
write(benchmark4.l[[1]], "benchmark4.labels0", ncolumns = 1)
write(as.matrix(benchmark4), "benchmark4.data", ncolumns = 2)
