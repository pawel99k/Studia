source("xmluj.R")

tags_count <- xmluj("photo.stackexchange.com/Tags.xml")
tags_count$Count <- as.numeric(tags_count$Count)
tags_count <- tags_count[, 2:3]

write.csv(tags_count, file = "photo_analysis/tags_count.csv")
