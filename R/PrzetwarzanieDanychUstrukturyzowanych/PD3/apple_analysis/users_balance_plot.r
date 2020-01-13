library(stringi)
library(ggplot2)
source("xmluj.R")
options(stringsAsFactors = FALSE)
xmluj("apple.stackexchange.com/Users.xml") -> Users

colnames(Users)
Users$LastAccessDate <- substring(Users$LastAccessDate, 0, 7)
Users$Reputation <- as.numeric(Users$Reputation)
Users[, 1:13 , LastAccessDate]

Users$UpVotes <- as.numeric(Users$UpVotes)
Users$DownVotes <- as.numeric(Users$DownVotes)
Users$UpVotes - Users$DownVotes -> Diff
cbind(Users, Diff) -> Users

Users[-1] -> Users #wykluczenie bota
Users[order(Users$Reputation)]




ggplot(Users[,.(Reputation, Diff)], aes(x = Diff, y = Reputation)) +
  geom_point(stat = "identity", size = 3, color = rgb(0, 0.5, 1, 0.2)) +
  coord_cartesian(xlim= c(min(Users$Diff)-1000, max(Users$Diff)+1000), ylim = c(-1000, max(Users$Reputation) + 1000)) +
  labs(title = "Scatter Plot", subtitle="Reputation vs Votes Difference") +
  annotate(geom="text", x=14361, y=154498, label="bmike") +
  annotate(geom="text", x=4300, y=131350, label="grg") +
  annotate(geom="text", x=11115, y=42609, label="Monomeeth") +
  annotate(geom="text", x=-2900, y=6000, label="user97627") +
  annotate(geom = "point", x = -2292, y = 140, color = "red") +
  annotate(geom = "point", x = 14361, y = 159498, color = "red") +
  annotate(geom = "point", x = 4300, y = 136350, color = "red") +
  annotate(geom = "point", x = 11115, y = 47609, color = "red") +
  xlab("Votes Difference")


rbind(Users[order(Users$Diff, decreasing = T)][1:10],
      Users[order(Users$Diff)][1:10],
      Users[order(Users$Reputation, decreasing = T)][1:10]) -> Exc_users

###
write.csv(Users[,.(Id, Reputation, Diff)], "apple_analysis/users_balance.csv" )

