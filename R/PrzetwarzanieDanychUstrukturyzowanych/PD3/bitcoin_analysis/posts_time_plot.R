library(ggplot2)
library(dplyr)
library(stringi)

options(stringsAsFactors = FALSE)

posts_time <- read.csv("bitcoin_analysis/posts_time.csv")[1:91, 2:3]
colnames(posts_time) <- c("Date", "Count")

BHDI <- read.csv("bitcoin_analysis/ext_data/Bitcoin-Historical-Data-Investing.com.csv")
BHDI <- BHDI[3:93, 1:2]
# zmiana formatu daty
BHDI$Date <- stri_datetime_parse(BHDI$Date, format = "LLL yy")
BHDI$Date <- stri_datetime_format(BHDI$Date, format = "yyyy-MM")
# usuniecie przecinkow z kursow
BHDI$Price <- stri_replace_all(BHDI$Price, replacement = "", regex = ",")
BHDI$Price <- as.numeric(BHDI$Price)

# przestarzaly zbior danych

# gemini_btcusd_d <- read.csv("bitcoin_analysis/ext_data/Gemini_BTCUSD_d.csv")
# gemini_btcusd_d <- gemini_btcusd_d[, c(1, 6)]
# gemini_btcusd_d$Date <- substr(gemini_btcusd_d$Date, 1, 7)
# gemini_btcusd_d <- gemini_btcusd_d %>%
#                    group_by(Date) %>%
#                    summarise(Price = mean(Close)) %>%
#                    ungroup()
# gemini_btcusd_d <- gemini_btcusd_d[1:41, ]

df <- inner_join(users_time, BHDI, by = "Date")
# wektor z nowym formate daty do wykresu
dates <- stri_datetime_parse(df$Date, format = "yyyy-MM")
dates <- stri_datetime_format(dates, format = "MM-yy")

ggplot(df) + 
  geom_bar(stat = "identity", width = 0.75, aes(Date, Count, fill = "Users Count")) +
  geom_line(aes(Date, Price/2, group = 1, color = "BTC Price")) +
  scale_x_discrete(labels = dates, name = "Date (Month-Year)") +
  scale_y_continuous("Monthly User Creation Count",
                     sec.axis = sec_axis(~ . * 2, name = "Monthly BTC Price (BTC/USD)")) +
  labs(title = "Time Series Chart", 
       subtitle = "Monthly User Creation Count vs Monthly BTC Price",
       caption = "Monthly BTC Price from https://investing.com/") +
  scale_colour_manual("", values = c("Users Count" = "forestgreen", "BTC Price" = "red")) +
  scale_fill_manual("", values = "forestgreen") +
  theme(legend.key = element_blank(),
        legend.title = element_blank(),
        legend.box = "horizontal",
        legend.position = "bottom",
        axis.text.x = element_text(size = 10, angle = 90, vjust = 0.4),
        axis.title.x = element_text(vjust = -0.5),
        axis.title.y.right = element_text(vjust = 1.5),
        axis.title.y.left = element_text(vjust = 1.5))
