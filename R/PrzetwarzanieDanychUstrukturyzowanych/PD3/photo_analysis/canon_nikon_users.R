library(dplyr)
library(stringi)

source("xmluj.R")

Users <- xmluj("photo.stackexchange.com/Users.xml")
Posts <- xmluj("photo.stackexchange.com/Posts.xml")

users <- select(Users, Id, DisplayName)

x <- stri_detect_regex(Posts$Tags, pattern = "<canon>")
canon <- filter(Posts, x)

y <- stri_detect_regex(Posts$Tags, pattern = "<nikon>")
nikon <- filter(Posts, y)

canon_users <- group_by(canon, OwnerUserId) %>%
  summarise(canon = n()) %>%
  na.omit() %>%
  inner_join(users, by = c('OwnerUserId' = 'Id')) %>%
  select(DisplayName, canon)

nikon_users <- group_by(nikon, OwnerUserId) %>%
  summarise(nikon = n()) %>%
  na.omit() %>%
  inner_join(users, by = c('OwnerUserId' = 'Id')) %>%
  select(DisplayName, nikon)

canon_nikon_users <- inner_join(canon_users, nikon_users)

write.csv(canon_users, file = 'photo_analysis/canon_users.csv')
write.csv(nikon_users, file = 'photo_analysis/nikon_users.csv')
write.csv(canon_nikon_users, file = 'photo_analysis/canon_nikon_users.csv')



