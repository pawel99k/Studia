
library(ggplot2)
options(stringsAsFactors = FALSE)
read.csv("summary/users_summary.csv") -> users_summary
rownames(users_summary) <- users_summary[,1]
users_summary <- users_summary[,-1]

for(i in 1:105){
  jpeg(paste("plot", toString(i), ".jpg", sep = ""))
  
  rownames(users_summary[i,]) -> y
  data.frame(cbind(t(users_summary[i,])[,1], colnames(users_summary))) -> x
  x$X1 <- as.numeric(x$X1)
  x <- x[c(1, 3, 2),]
  p <- ggplot(x, aes(x = X2, y = X1)) +
    geom_bar(stat="identity", width = 0.7, fill =c("#737373", "#ffcc00", "#cc0000"))  +
    annotate(geom = "text", x = 3.3, y = 237000, label = y, colour="#0d0d0d", size = 5.2 ) +
    xlab("Site") + ylab("Users") +
    theme_minimal()
  print(p)
  dev.off() 
}

#nastepnie formatowanie gifa za pomoca serwisu ezgif.com
