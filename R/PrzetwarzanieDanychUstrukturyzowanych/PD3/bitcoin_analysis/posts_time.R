options(stringsAsFactors = FALSE)

source("xmluj.R")

Posts <- xmluj("bitcoin.stackexchange.com/Posts.xml")

#liczba postow na przestrzeni czasu
write.csv(table(substring(Posts[,CreationDate], first = 0, last=7)), "bitcoin_analysis/posts_time.csv")
