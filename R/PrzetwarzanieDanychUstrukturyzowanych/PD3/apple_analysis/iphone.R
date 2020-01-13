library(stringi)
source("xmluj.R")
options(stringsAsFactors = FALSE)
xmluj("apple.stackexchange.com/Posts.xml") -> Posts
xmluj("apple.stackexchange.com/Tags.xml") -> Tags


Posts$CreationDate <- substring(Posts$CreationDate, first = 0, last = 7)


stri_extract_all_regex(Posts$Tags, "[^<].*[^>]") -> lista.tagow

stri_count_regex(Posts$Tags, "<") -> liczba.tagow
liczba.tagow[is.na(liczba.tagow)] <- 1


stri_split_regex(lista.tagow, "><") -> lista.tagow

rep(Posts$Id, liczba.tagow) -> powtorzone.id.postow

cbind(powtorzone.id.postow, unlist(lista.tagow)) -> tagi


data.frame(tagi) -> tagi
colnames(tagi)[2] <- "tag"

tagi[tagi$tag=="iphone" & !is.na(tagi$tag), "powtorzone.id.postow"] -> iphone.postid

table(Posts[Posts$Id %in% iphone.postid, "CreationDate"])[c(-(1:5), -110)] -> liczba.postow.iphone

data.frame(liczba.postow.iphone) -> liczba.postow.iphone

