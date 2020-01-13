library(lubridate)

df <- economics_long[economics_long$variable %in% c("psavert", "uempmed"), ]
df <- df[lubridate::year(df$date) %in% c(1967:1981), ]

canon_posts_time <- read.csv("photo_analysis/canon_posts_time.csv")[1:104, 2:3]
nikon_posts_time <- read.csv("photo_analysis/nikon_posts_time.csv")[1:104, 2:3]
colnames(canon_posts_time) <- c("Date", "Count")
colnames(nikon_posts_time) <- c("Date", "Count")

canon_posts_time <- cbind(canon_posts_time, Tag = rep("canon", times = length(canon_posts_time[[1]])))
nikon_posts_time <- cbind(nikon_posts_time, Tag = rep("nikon", times = length(nikon_posts_time[[1]])))

df <- rbind(canon_posts_time, nikon_posts_time)

dates <- stri_datetime_parse(canon_posts_time$Date, format = "yyyy-MM")
dates <- stri_datetime_format(dates, format = "MM-yy")

ggplot(df, aes(x=Date, y=Count)) + 
  geom_line(aes(col=Tag, group = Tag)) +
  labs(title="Time Series of Monthly Posts", 
       subtitle="Monthly Posts grouped by Tag", 
       y="MonthlyPosts") +
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  scale_color_manual(values = c("#BC0024", "#FFE100")) +
  theme_dark() +
  theme(axis.text.x = element_text(size = 10, angle = 90, vjust = 0.4),
        panel.grid.minor = element_blank())
