library(ggplot2)
library(stringi)

posts_time <- read.csv("photo_analysis/posts_time.csv")[1:104, 2:3]
colnames(posts_time) <- c("Date", "Count")

dates <- stri_datetime_parse(posts_time$Date, format = "yyyy-MM")
dates <- stri_datetime_format(dates, format = "MM-yy")

ggplot(posts_time, aes(x = Date, y = Count)) + 
  geom_bar(stat = "identity", width = .5, fill = "deepskyblue4") +
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  labs(title = "Bar Chart", subtitle="Posts Vs Date") +
  theme(axis.text.x = element_text(size = 10, angle = 90, vjust = 0.4))