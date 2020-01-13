library(stringi)
source("xmluj.R")
options(stringsAsFactors = FALSE)
xmluj("apple.stackexchange.com/Users.xml") -> Users1
xmluj("photo.stackexchange.com/Users.xml") -> Users2
xmluj("bitcoin.stackexchange.com/Users.xml") -> Users3

Users1$CreationDate <- substring(Users1$CreationDate, 0, 7)
Users2$CreationDate <- substring(Users2$CreationDate, 0, 7)
Users3$CreationDate <- substring(Users3$CreationDate, 0, 7)



data.frame(c(0, cumsum(table(Users1$CreationDate))),
           cumsum(table(Users2$CreationDate), c(rep(0, 14), cumsum(table(Users3$CreationDate))))) -> users_summary
colnames(users_summary) <- c("Apple", "Photo", "Bitcoin")

