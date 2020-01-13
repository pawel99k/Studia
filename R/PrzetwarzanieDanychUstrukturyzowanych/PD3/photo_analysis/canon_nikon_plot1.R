library(ggplot2)

canon_users <- read.csv("photo_analysis/canon_users.csv")
nikon_users <- read.csv("photo_analysis/nikon_users.csv")
canon_nikon_users <- read.csv("photo_analysis/canon_nikon_users.csv")

x <- length(canon_users[[1]])
y <- length(nikon_users[[1]])
z <- length(canon_nikon_users[[1]])

df <- as.data.frame(cbind(c('Users posting under Canon tag only',
                            'Users posting under both tags',
                            'Users posting under Nikon tag only'),
                          c(x-z, z, y-z)))
colnames(df) <- c("Class", "freq")
df$freq <- as.numeric(df$freq)


df <- df %>%
  arrange(desc(Class)) %>%
  mutate(prop = freq/sum(freq))

df <- df %>%
  arrange(desc(Class)) %>%
  mutate(lab.ypos = cumsum(prop) - 0.5*prop)

mycols <- c("#868686FF", "#BC0024", "#FFE100")

ggplot(df, aes(x = 2, y = prop, fill = Class)) +
  geom_bar(stat = "identity", color = "white") +
  coord_polar(theta = "y", start = 0) +
  geom_text(aes(y = lab.ypos, label = freq), color = "black") +
  scale_fill_manual(values = mycols) +
  xlim(0.5, 2.5) +
  labs(title="Pie Chart of class") +
  theme_void() +
  theme(plot.title = element_text(hjust = 0.5, vjust = -5, face = "bold"))

