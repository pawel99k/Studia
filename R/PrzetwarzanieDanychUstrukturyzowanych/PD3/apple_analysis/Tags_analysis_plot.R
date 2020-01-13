options(stringsAsFactors = FALSE)
library(ggplot2)
library(stringi)

read.csv("apple_analysis/Tags_analysis_ios.csv")[1:102,-1] -> tagsios
read.csv("apple_analysis/Tags_analysis_iphone.csv")[1:102,-1] -> tagsiphone
read.csv("apple_analysis/Tags_analysis_itunes.csv")[1:102,-1] -> tagsitunes
read.csv("apple_analysis/Tags_analysis_macbook.csv")[1:102,-1] -> tagsmacbook
read.csv("apple_analysis/Tags_analysis_macos.csv")[1:102,-1] -> tagsmacos

dates <- stri_datetime_parse(tagsios$Var1, format = "yyyy-MM")
dates <- stri_datetime_format(dates, format = "MM-yy")

ggplot(tagsitunes, aes(Var1, Freq)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "blue") + 
  geom_bar(stat = "identity", width  = 0.5) + 
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.8, size = 7, face = "bold")) +
  annotate(geom = "text", x = 88, y = 7.5, label = "Tag: itunes", colour="#0d0d0d", size = 5.2 ) +
  xlab("Month") + ylab("Tag Usage Increase") +
  labs(title = "Bar Chart", subtitle="Tag Usage Increase accross date")

ggplot(tagsmacbook, aes(Var1, Freq)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "blue") + 
  geom_bar(stat = "identity", width  = 0.5) + 
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.8, size = 7, face = "bold")) +
  annotate(geom = "text", x = 88, y = 7.5, label = "Tag: macbook", colour="#0d0d0d", size = 5.2 ) +
  xlab("Month") + ylab("Tag Usage Increase") +
  labs(title = "Bar Chart", subtitle="Tag Usage Increase accross date")

ggplot(tagsmacos, aes(Var1, Freq)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "blue") + 
  geom_bar(stat = "identity", width  = 0.5) + 
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.8, size = 7, face = "bold"))+
  annotate(geom = "text", x = 88, y = 7.5, label = "Tag: macos", colour="#0d0d0d", size = 5.2 ) +
  xlab("Month") + ylab("Tag Usage Increase") +
  labs(title = "Bar Chart", subtitle="Tag Usage Increase accross date")


ggplot(tagsiphone, aes(Var1, Freq)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "blue") + 
  geom_bar(stat = "identity", width  = 0.5) + 
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.8, size = 7, face = "bold")) +
  annotate(geom = "text", x = 88, y = 7.5, label = "Tag: iphone", colour="#0d0d0d", size = 5.2 ) +
  xlab("Month") + ylab("Tag Usage Increase") +
  labs(title = "Bar Chart", subtitle="Tag Usage Increase accross date")  

ggplot(tagsios, aes(Var1, Freq)) +
  geom_hline(yintercept = 1, linetype = "dashed", color = "blue") + 
  geom_bar(stat = "identity", width  = 0.5) + 
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.8, size = 7, face = "bold")) +
  annotate(geom = "text", x = 88, y = 7.5, label = "Tag: ios", colour="#0d0d0d", size = 5.2 ) +
  xlab("Month") + ylab("Tag Usage Increase") +
  labs(title = "Bar Chart", subtitle="Tag Usage Increase accross date")  
