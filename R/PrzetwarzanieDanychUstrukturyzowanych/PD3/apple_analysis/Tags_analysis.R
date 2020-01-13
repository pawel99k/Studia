library(stringi)
source("xmluj.R")
options(stringsAsFactors = FALSE)
xmluj("apple.stackexchange.com/Tags.xml") -> Tags
Tags$Count <- as.numeric(Tags$Count)
Tags[order(Tags$Count, decreasing = T)]

xmluj("apple.stackexchange.com/Posts.xml") -> Posts


Posts$CreationDate <- substring(Posts$CreationDate, first = 0, last = 7)
stri_extract_all_regex(Posts$Tags, "[^<].*[^>]") -> lista.tagow
stri_count_regex(Posts$Tags, "<") -> liczba.tagow
liczba.tagow[is.na(liczba.tagow)] <- 1
stri_split_regex(lista.tagow, "><") -> lista.tagow
rep(Posts$Id, liczba.tagow) -> powtorzone.id.postow
cbind(powtorzone.id.postow, unlist(lista.tagow)) -> tagi
data.frame(tagi) -> tagi
colnames(tagi) <- c("PostId", "tag")

tagi[tagi$tag=="macos" & !is.na(tagi$tag), "PostId"] -> macos.postid
tagi[tagi$tag=="iphone" & !is.na(tagi$tag), "PostId"] -> iphone.postid
tagi[tagi$tag=="macbook" & !is.na(tagi$tag), "PostId"] -> macbook.postid
tagi[tagi$tag=="ios" & !is.na(tagi$tag), "PostId"] -> ios.postid
tagi[tagi$tag=="itunes" & !is.na(tagi$tag), "PostId"] -> itunes.postid

table(Posts[Posts$Id %in% macos.postid, "CreationDate"])[c(-(1:11))] -> liczba.postow.macos

table(Posts[Posts$Id %in% iphone.postid, "CreationDate"])[c(-(1:5))] -> liczba.postow.iphone

table(Posts[Posts$Id %in% macbook.postid, "CreationDate"])[c(-(1:4))] -> liczba.postow.macbook

table(Posts[Posts$Id %in% ios.postid, "CreationDate"])[c(-(1:5))] -> liczba.postow.ios

table(Posts[Posts$Id %in% itunes.postid, "CreationDate"])[c(-(1:3))] -> liczba.postow.itunes


barplot(liczba.postow.macos)
barplot(liczba.postow.iphone)
barplot(liczba.postow.macbook)
barplot(liczba.postow.ios)
barplot(liczba.postow.itunes)

barplot(liczba.postow.macos[-1]/liczba.postow.macos[-104])
barplot(liczba.postow.iphone[-1]/liczba.postow.iphone[-105])
barplot(liczba.postow.macbook[-1]/liczba.postow.macbook[-104])
barplot(liczba.postow.ios[-1]/liczba.postow.ios[-105])
barplot(liczba.postow.itunes[-1]/liczba.postow.itunes[-104])
liczba.postow.ios[-1]/liczba.postow.ios[-105] #2011-10


Posts[Posts$Id %in% ios.postid & Posts$CreationDate=="2011-10"]
