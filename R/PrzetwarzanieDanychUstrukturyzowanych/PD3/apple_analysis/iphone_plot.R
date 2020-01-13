library(ggplot2)
options(stringsAsFactors = FALSE)
read.csv("apple_analysis/iphone.csv")[,-1] -> liczba.postow.iphone

p<-ggplot(liczba.postow.iphone, aes(x=Var1, y=Freq, fill=Var1)) +
  geom_bar(stat="identity", width = 0.5)

xaxisTitles <- c("iPhone 4", rep("", 14),
                 " 4s",  rep("", 10),
                 " 5",  rep("", 11),
                 " 5s, 5c", rep("", 11),
                 " 6, 6+", rep("", 11),
                 " 6s, 6s+", rep("", 5),
                 " SE", rep("", 5),
                 " 7, 7+", rep("", 11),
                 " 8, 8+", rep("", 2),
                 " X", rep("", 8),
                 " Xr, Xs, Xsmax", rep("", 5))

p+scale_fill_manual(values=c("#ff9999", rep("#999999", 14),
                             "#ff1a1a", "#ff9999", rep("#999999", 9),
                             "#ff1a1a", "#ff9999", rep("#999999", 10),
                             "#ff1a1a", "#ff9999", rep("#999999", 10),
                             "#ff1a1a", "#ff9999", rep("#999999", 10),
                             "#ff1a1a", "#ff9999", rep("#999999", 4),
                             "#ff1a1a", "#ff9999", rep("#999999", 4),
                             "#ff1a1a", "#ff9999", rep("#999999", 10),
                             "#ff1a1a", "#ff9999",
                             "#ff1a1a", "#ff9999", rep("#999999", 8),
                             "#ff1a1a", "#ff9999", rep("#999999", 4))) +
  theme(legend.position="none") +
  scale_x_discrete(labels=xaxisTitles) +
  labs(title = "Bar Chart", 
       subtitle = "Posts vs Date") +
  theme(axis.text.x = element_text(angle = 0, vjust = 0.4, size = 15, face = "bold")) +
  theme(
    panel.border = element_blank(),  
    panel.grid.major = element_blank(),
    axis.line = element_line(colour = "black")
  ) +
  xlab("iPhone Model Premieres") + ylab("Posts Count under \"iPhone\" tag")

