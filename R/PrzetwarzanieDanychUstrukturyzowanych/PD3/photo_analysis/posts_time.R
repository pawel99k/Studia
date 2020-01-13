options(stringsAsFactors = FALSE)

source("xmluj.R")

Posts <- xmluj("photo.stackexchange.com/Posts.xml")

#liczba postow na przestrzeni czasu
write.csv(table(substring(Posts[,CreationDate], first = 0, last=7)), "photo_analysis/posts_time.csv")
