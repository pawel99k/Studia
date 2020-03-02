#plik do wczytania zbiorów testowych oraz utworzenia funkcji do estetycznego malowania wykresów



#fcps
atom <- read.csv("F:/Projekt/fcps/atom.data.gz", header = F, sep = "\t", comment.char="#")
chainlink <- read.csv("F:/Projekt/fcps/chainlink.data.gz", header = F, sep = "\t", comment.char="#" )
engytime <- read.csv("F:/Projekt/fcps/engytime.data.gz", header = F, sep = "\t", comment.char="#")
hepta <- read.csv("F:/Projekt/fcps/hepta.data.gz", header = F, sep = "\t", comment.char="#" )
lsun <- read.csv("F:/Projekt/fcps/lsun.data.gz", header = F, sep = " ", comment.char="#")
target <- read.csv("F:/Projekt/fcps/target.data.gz", header = F, sep = " ", comment.char="#" )
tetra <- read.csv("F:/Projekt/fcps/tetra.data.gz", header = F, sep = "\t", comment.char="#")
twodiamonds <- read.csv("F:/Projekt/fcps/twodiamonds.data.gz",header = F,  sep = "\t", comment.char="#" )
wingnut <- read.csv("F:/Projekt/fcps/wingnut.data.gz", header = F, sep = "\t", comment.char="#")

atom.l <- read.csv("F:/Projekt/fcps/atom.labels0.gz", header = F, sep = "\t", comment.char="#")
chainlink.l <- read.csv("F:/Projekt/fcps/chainlink.labels0.gz", header = F, sep = "\t", comment.char="#" )
engytime.l <- read.csv("F:/Projekt/fcps/engytime.labels0.gz", header = F, sep = "\t", comment.char="#")
hepta.l <- read.csv("F:/Projekt/fcps/hepta.labels0.gz", header = F, sep = "\t", comment.char="#" )
lsun.l <- read.csv("F:/Projekt/fcps/lsun.labels0.gz", header = F, sep = " ", comment.char="#")
target.l <- read.csv("F:/Projekt/fcps/target.labels0.gz", header = F, sep = " ", comment.char="#" )
tetra.l <- read.csv("F:/Projekt/fcps/tetra.labels0.gz", header = F, sep = "\t", comment.char="#")
twodiamonds.l <- read.csv("F:/Projekt/fcps/twodiamonds.labels0.gz", header = F, sep = "\t", comment.char="#" )
wingnut.l <- read.csv("F:/Projekt/fcps/wingnut.labels0.gz", header = F, sep = "\t", comment.char="#")

#graves
dense <- read.csv("F:/Projekt//graves/dense.data.gz", header = F, sep = " ")
fuzzyx <- read.csv("F:/Projekt//graves/fuzzyx.data.gz", header = F, sep = " ")
line<- read.csv("F:/Projekt//graves/line.data.gz", header = F, sep = " ")
parabolic <- read.csv("F:/Projekt//graves/parabolic.data.gz", header = F, sep = " ")
ring <- read.csv("F:/Projekt//graves/ring.data.gz", header = F, sep = " ")
zigzag <- read.csv("F:/Projekt//graves/zigzag.data.gz", header = F, sep = " ")

dense.l <- read.csv("F:/Projekt//graves/dense.labels0.gz", header = F, sep = " ")
fuzzyx.l <- read.csv("F:/Projekt//graves/fuzzyx.labels0.gz", header = F, sep = " ")
line.l <- read.csv("F:/Projekt//graves/line.labels0.gz", header = F, sep = " ")
parabolic.l <- read.csv("F:/Projekt//graves/parabolic.labels0.gz", header = F, sep = " ")
ring.l <- read.csv("F:/Projekt//graves/ring.labels0.gz", header = F, sep = " ")
zigzag.l <- read.csv("F:/Projekt//graves/zigzag.labels0.gz", header = F, sep = " ")


#other
iris <- read.csv("F:/Projekt//other/iris.data.gz", header = F, sep = " ")
iris5 <- read.csv("F:/Projekt//other/iris5.data.gz", header = F, sep = " ")
square <- read.csv("F:/Projekt//other/square.data.gz", header = F, sep = " ")

iris.l <- read.csv("F:/Projekt//other/iris.labels0.gz", header = F, sep = " ")
iris5.l <- read.csv("F:/Projekt//other/iris5.labels0.gz", header = F, sep = " ")
square.l <- read.csv("F:/Projekt//other/square.labels0.gz", header = F, sep = " ")

#sipu
a1 <- read.csv("F:/Projekt//sipu/a1.data.gz", header = F, sep = " ")
a2 <- read.csv("F:/Projekt//sipu/a2.data.gz", header = F, sep = " ")
a3 <- read.csv("F:/Projekt//sipu/a3.data.gz", header = F, sep = " ")
aggregation <- read.csv("F:/Projekt//sipu/aggregation.data.gz", header = F, sep = " ")
compound <- read.csv("F:/Projekt//sipu/compound.data.gz", header = F, sep = " ")
d31 <- read.csv("F:/Projekt//sipu/d31.data.gz", header = F, sep = " ")
flame <- read.csv("F:/Projekt//sipu/flame.data.gz", header = F, sep = " ")
jain <- read.csv("F:/Projekt//sipu/jain.data.gz", header = F, sep = " ")
pathbased <- read.csv("F:/Projekt//sipu/pathbased.data.gz", header = F, sep = " ")
r15 <- read.csv("F:/Projekt//sipu/r15.data.gz", header = F, sep = " ")
s1 <- read.csv("F:/Projekt//sipu/s1.data.gz", header = F, sep = " ")
s2 <- read.csv("F:/Projekt//sipu/s2.data.gz", header = F, sep = " ")
s3 <- read.csv("F:/Projekt//sipu/s3.data.gz", header = F, sep = " ")
s4 <- read.csv("F:/Projekt//sipu/s4.data.gz", header = F, sep = " ")
spiral <- read.csv("F:/Projekt//sipu/spiral.data.gz", header = F, sep = " ")
unbalance <- read.csv("F:/Projekt//sipu/unbalance.data.gz", header = F, sep = " ")

a1.l <- read.csv("F:/Projekt//sipu/a1.labels0.gz", header = F, sep = " ")
a2.l <- read.csv("F:/Projekt//sipu/a2.labels0.gz", header = F, sep = " ")
a3.l <- read.csv("F:/Projekt//sipu/a3.labels0.gz", header = F, sep = " ")
aggregation.l <- read.csv("F:/Projekt//sipu/aggregation.labels0.gz", header = F, sep = " ")
compound.l <- read.csv("F:/Projekt//sipu/compound.labels0.gz", header = F, sep = " ")
d31.l <- read.csv("F:/Projekt//sipu/d31.labels0.gz", header = F, sep = " ")
flame.l <- read.csv("F:/Projekt//sipu/flame.labels0.gz", header = F, sep = " ")
jain.l <- read.csv("F:/Projekt//sipu/jain.labels0.gz", header = F, sep = " ")
pathbased.l <- read.csv("F:/Projekt//sipu/pathbased.labels0.gz", header = F, sep = " ")
r15.l <- read.csv("F:/Projekt//sipu/r15.labels0.gz", header = F, sep = " ")
s1.l <- read.csv("F:/Projekt//sipu/s1.labels0.gz", header = F, sep = " ")
s2.l <- read.csv("F:/Projekt//sipu/s2.labels0.gz", header = F, sep = " ")
s3.l <- read.csv("F:/Projekt//sipu/s3.labels0.gz", header = F, sep = " ")
s4.l <- read.csv("F:/Projekt//sipu/s4.labels0.gz", header = F, sep = " ")
spiral.l <- read.csv("F:/Projekt//sipu/spiral.labels0.gz", header = F, sep = " ")
unbalance.l <- read.csv("F:/Projekt//sipu/unbalance.labels0.gz", header = F, sep = " ")

#wut
cross <- read.csv("F:/Projekt//wut/cross.data.gz", header = F, sep = " ")
smile <- read.csv("F:/Projekt//wut/smile.data.gz", header = F, sep = " ")
twosplashes <- read.csv("F:/Projekt//wut/twosplashes.data.gz", header = F, sep = " ")
x1 <- read.csv("F:/Projekt//wut/x1.data.gz", header = F, sep = " ")
x2 <- read.csv("F:/Projekt//wut/x2.data.gz", header = F, sep = " ")
x3 <- read.csv("F:/Projekt//wut/x3.data.gz", header = F, sep = " ")
z1 <- read.csv("F:/Projekt//wut/z1.data.gz", header = F, sep = " ")
z2 <- read.csv("F:/Projekt//wut/z2.data.gz", header = F, sep = " ")
z3 <- read.csv("F:/Projekt//wut/z3.data.gz", header = F, sep = " ")

cross.l <- read.csv("F:/Projekt//wut/cross.labels0.gz", header = F, sep = " ")
smile.l <- read.csv("F:/Projekt//wut/smile.labels0.gz", header = F, sep = " ")
twosplashes.l <- read.csv("F:/Projekt//wut/twosplashes.labels0.gz", header = F, sep = " ")
x1.l <- read.csv("F:/Projekt//wut/x1.labels0.gz", header = F, sep = " ")
x2.l <- read.csv("F:/Projekt//wut/x2.labels0.gz", header = F, sep = " ")
x3.l <- read.csv("F:/Projekt//wut/x3.labels0.gz", header = F, sep = " ")
z1.l <- read.csv("F:/Projekt//wut/z1.labels0.gz", header = F, sep = " ")
z2.l <- read.csv("F:/Projekt//wut/z2.labels0.gz", header = F, sep = " ")
z3.l <- read.csv("F:/Projekt//wut/z3.labels0.gz", header = F, sep = " ")

benchmark2 <- read.csv("F:/Projekt//benchmark2.data", header=F, sep = " ")
benchmark3 <- read.csv("F:/Projekt//benchmark3.data", header=F, sep = " ")
benchmark4 <- read.csv("F:/Projekt//benchmark4.data", header=F, sep = " ")

benchmark2.l <- read.csv("F:/Projekt//benchmark2.labels0", header=F, sep = " ")
benchmark3.l <- read.csv("F:/Projekt//benchmark3.labels0", header=F, sep = " ")
benchmark4.l <- read.csv("F:/Projekt//benchmark4.labels0", header=F, sep = " ")


maluj <- function(X, X.l){
  require(plotly)
  if(ncol(X)==2){
    C <- X
  for(i in 1:max(X.l)){
  C[X.l==i, 3] <- i
  }
  p <- plot_ly(C, x = ~V1, y = ~V2, color = ~V3 ) %>%
    add_markers()
  }
  if(ncol(X)==3){
    C <- X
    for(i in 1:max(X.l)){
      C[X.l==i, 4] <- i
    }
    p <- plot_ly(C, x = ~V1, y = ~V2, z = ~V3, color = ~V4) %>%
      add_markers()
  }
  if(!ncol(X) %in% c(2, 3)){
   print("sorry, nie wiem jak to namalowaÄ‡")
   p <- NULL
  }
  p
}
