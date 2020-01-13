library(ggplot2)

canon_nikon_users <- read.csv("photo_analysis/canon_nikon_users.csv")[2:4]
canon_nikon_users <- canon_nikon_users[order(canon_nikon_users$canon+canon_nikon_users$nikon, decreasing = TRUE), ]
canon_nikon_users <- canon_nikon_users[1:25, ]

canon_nikon_users$DisplayName <- reorder(canon_nikon_users$DisplayName, rowSums(canon_nikon_users[-1]))

df <- melt(canon_nikon_users, id=(c("DisplayName"))) %>%
  group_by(DisplayName) %>%
  arrange(DisplayName, desc(variable)) %>%
  mutate(lab_ypos = cumsum(value) - 0.5 * value)

colnames(df) <- c("DisplayName", "Tag", "Posts", "lab_ypos")

ggplot(df, aes(x = DisplayName, y = Posts)) +
  geom_col(aes(fill = Tag), width = 0.8) +
  geom_text(aes(y = lab_ypos, label = Posts, group = Tag), color = "black") +
  labs(title = "Histogram on Categorical Variable", subtitle="Users accross Categorized Posts") + 
  theme(axis.text.x = element_text(angle = 65, vjust = 0.5)) +
  scale_fill_manual(values = c("#BC0024", "#FFE100"))
