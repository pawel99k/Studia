library(ggplot2)

users_countries <- read.csv("bitcoin_analysis/users_countries.csv")[, 2:3]
colnames(users_countries) <- c("country", "count")
users_countries <- users_countries[order(users_countries$count), ]
users_countries <- tail(users_countries, 25)

countries_flags <- rev(c('United States \U1F1FA\U1F1F8', 
                         'India \U1F1EE\U1F1F3', 
                         'United Kingdom \U1F1EC\U1F1E7',
                         'Germany \U1F1E9\U1F1EA',
                         'Canada \U1F1E8\U1F1E6',
                         'Australia \U1F1E6\U1F1FA',
                         'France \U1F1EB\U1F1F7',
                         'Brazil \U1F1E7\U1F1F7',
                         'Netherlands \U1F1F3\U1F1F1',
                         'Russian Federation \U1F1F7\U1F1FA',
                         'Italy \U1F1EE\U1F1F9',
                         'China \U1F1E8\U1F1F3',
                         'Spain \U1F1EA\U1F1F8',
                         'Switzerland \U1F1E8\U1F1ED',
                         'Poland \U1F1F5\U1F1F1',
                         'Turkey \U1F1F9\U1F1F7',
                         'Iran \U1F1EE\U1F1F7',
                         'Sweden \U1F1F8\U1F1EA', 
                         'Israel \U1F1EE\U1F1F1', 
                         'Pakistan \U1F1F5\U1F1F0',
                         'Ukraine \U1F1FA\U1F1E6',
                         'South Africa \U1F1FF\U1F1E6',
                         'Bangladesh \U1F1E7\U1F1E9',
                         'Czech Republic \U1F1E8\U1F1FF',
                         'Belgium \U1F1E7\U1F1EA'))

countries_flags <- factor(countries_flags, levels = countries_flags)

ggplot(users_countries, aes(x = countries_flags, y = users_countries$count)) + 
  geom_bar(stat="identity", width=.5, fill="tomato3") +
  geom_text(aes(label = count), size = 3, hjust = -0.1, vjust = 0.4, position = "stack") +
  xlab('Country') +
  ylab('Count') +
  labs(title="Ordered Horizontal Bar Chart", 
       subtitle="Country Vs Count") + 
  coord_flip()

