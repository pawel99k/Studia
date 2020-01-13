library(ggplot2)

tags_count <- read.csv("photo_analysis/tags_count.csv")[, 2:3]
colnames(tags_count) <- c("tag", "count")
tags_count <- tags_count[order(tags_count$count), ]
tags_count <- tail(tags_count, 25)
tags_count$tag <- factor(tags_count$tag, levels = tags_count$tag)

ggplot(tags_count, aes(x = tags_count$tag, y = tags_count$count)) + 
  geom_bar(stat="identity", width=.5, fill="deepskyblue4") +
  geom_text(aes(label = tags_count$count), size = 3, hjust = -0.1, vjust = 0.4, position = "stack") +
  xlab('Tag') +
  ylab('Count') +
  labs(title="Ordered Horizontal Bar Chart", 
       subtitle="Tag Vs Count") + 
  coord_flip()
