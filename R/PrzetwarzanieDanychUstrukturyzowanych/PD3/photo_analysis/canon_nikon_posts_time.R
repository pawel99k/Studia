library(dplyr)
library(stringi)

source("xmluj.R")

Posts <- xmluj("photo.stackexchange.com/Posts.xml")

x <- stri_detect_regex(Posts$Tags, pattern = "<canon>")
canon <- filter(Posts, x)

y <- stri_detect_regex(Posts$Tags, pattern = "<nikon>")
nikon <- filter(Posts, y)

write.csv(table(substring(canon[,"CreationDate"], first = 0, last=7)), "photo_analysis/canon_posts_time.csv")
write.csv(table(substring(nikon[,"CreationDate"], first = 0, last=7)), "photo_analysis/nikon_posts_time.csv")