#ostateczna funkcja
spectral_clustering <- function(X, k, M){
  require(igraph)
  stopifnot(k>1)
  stopifnot(is.numeric(M), M>0, M <= nrow(X))
  stopifnot(floor(M)==M)
  stopifnot(nrow(X)<=50000)
  
  Mnn <- function(X, M){
    #Wynik: macierz, ktorej dla kazdego wiersza 'i', kolejne kolumny zawieraja indeksy najblizszych sasiadow punktu 'i' (metr. Euklidesowa)
    distances <- as.matrix(dist(X)) #odleglosci miedzy punktami wzgledem metryki euklidesowej
    t(sapply(split(distances, 1:nrow(distances)), order))[,2:(M+1)] -> S #1. kolumna dla kazdego punktu 'i' była 'i', odrzucamy.
    S
  }
  
  Mnn_graph <- function(S){
    stopifnot(is.matrix(S))
    #ncol(S) -> M
    nrow(S) -> n
    
    cbind(rep(1:n, each=M), split(t(S), M)[[1]]) -> edgesOfG #ktore krawedzie grafu maja byc polaczone
    g <- graph.edgelist(edgesOfG, directed=F) #g jest grafem nieskierowanym
    
    if(!is_connected(g)){ #jesli graf nie jest spojny
      newEdges <- which(!duplicated(components(g)$membership))    #newEdges jest zbiorem wierzchołków, ktore parami naleza do innych skladowych.
      c(newEdges[1], rep(newEdges[2:(length(newEdges)-1)], each=2), newEdges[length(newEdges)] ) -> edgesToAdd #nowe krawedzie - w celu uspojnienia grafu
      g <- g+edge(edgesToAdd)
    }
    stopifnot(is_connected(g))  #tu juz spojny musi byc
    G <- as.matrix(get.adjacency(g, type="both")) #z prob wynika, ze matrix dziala szybciej niz sparse matrix
    G[G==2] <- 1 #niektore pary wierzcholkow byly polaczone podwojnie
    G
    }
  
  Laplacian_eigen <- function(G, k){
    n <- nrow(G)
    sapply(split(G, 1:n), sum) -> degrees
    Laplacian <- diag(degrees) - G
    eigen(Laplacian, symmetric = T)$vectors[, (n-1):(n-k)] -> eigenvectors
    eigenvectors
  }
  mnn <- Mnn(X, M)
  graf <- Mnn_graph(mnn)
  eigenvectors <- Laplacian_eigen(graf, k)
  stats::kmeans(eigenvectors, k)
}

