source("xmluj.R")

xmluj("bitcoin.stackexchange.com/Posts.xml") -> Posts

Posts1 <- Posts[PostTypeId==1,]
Posts2 <- Posts[PostTypeId==2]
Posts1$ViewCount <- as.numeric(Posts1$ViewCount)
Posts2$ParentId <- as.numeric(Posts2$ParentId)
Posts2$Score <- as.numeric(Posts2$Score)


Posts1[order(Posts1$ViewCount, decreasing = TRUE)][1:5,] -> bestquestions
bestquestions$Id -> bqId
Posts2[ParentId %in% bqId] -> bqanswers
bqanswers[order(bqanswers$ParentId, bqanswers$Score, decreasing = T)] -> bqanswers
bqanswers[!duplicated(bqanswers$ParentId), c(6, 18)] -> ba
bestquestions[,c(1, 5, 6, 11)] -> bq
bq$Id <- as.numeric(bq$Id)
merge(bq, ba, by.y = "ParentId", by.x = "Id") -> out

colnames(out)[5] <- "Answer"
out[order(out$ViewCount, decreasing = T),] -> out

head(out$Title)
head(out$Answer)