options(stringsAsFactors = FALSE)

source("xmluj.R")

Users <- xmluj("bitcoin.stackexchange.com/Users.xml")

users_time <- select(Users, CreationDate) %>%
              transmute("Date" = substr(CreationDate, 1, 7)) %>%
              group_by(Date) %>%
              summarise("Count" = n())

write.csv(users_time, file = "bitcoin_analysis/users_time.csv")