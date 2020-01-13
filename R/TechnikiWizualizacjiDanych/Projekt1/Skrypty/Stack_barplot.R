library("intsvy")
library("dplyr")
library("ggplot2")
library("tidyr")

get_data_of_questions <- function(questions){
  require(stringr)
  all_questions_names <- colnames(students)
  basic_info <- students[,c(2,3,4,21)]
  all_questions <- basic_info
  
  for(question in questions[-1]){
    regEXP <- paste0(questions[1],"0?0?",toString(question),".{5}\\b")
    found_questions <- str_extract(all_questions_names,regEXP)
    all_questions <-cbind(all_questions,students[found_questions[!is.na(found_questions)]])
  }
  return(all_questions)
}
questions_IC <- c("IC",6)
data_of_all_questions <-  get_data_of_questions(questions_IC)
COUNTRIES <- unique(data_of_all_questions$CNT)

EUROPE <- COUNTRIES[c(1, 4, 5, 7, 13, 14, 15, 17, 18, 19, 21, 22, 24, 25, 27, 29, 33, 35, 36, 37, 39, 41, 42, 43, 45, 47, 48, 50, 51, 53, 55, 56, 57, 58, 64, 65, 68)]
ASIA <- COUNTRIES[!COUNTRIES %in% EUROPE][c( 6, 10, 11, 12, 13, 14, 15, 16, 17, 18, 22, 23, 24, 25, 29, 32  )]
AUSTRALIA <- COUNTRIES[!(COUNTRIES %in% EUROPE | COUNTRIES %in% ASIA)][c(2, 10)]
SOUTH_AMERICA <- COUNTRIES[!(COUNTRIES %in% EUROPE | COUNTRIES %in% ASIA)][c(3, 5, 6, 7, 11, 13, 15, 16)]
AFRICA <- COUNTRIES[!(COUNTRIES %in% EUROPE | COUNTRIES %in% ASIA | COUNTRIES %in% AUSTRALIA | COUNTRIES %in% SOUTH_AMERICA)][c(1, 6)]
NORTH_AMERICA <- COUNTRIES[!(COUNTRIES %in% EUROPE | COUNTRIES %in% ASIA | COUNTRIES %in% AUSTRALIA | COUNTRIES %in% SOUTH_AMERICA)][c(-1, -6)]

Continents <- data_of_all_questions %>%
  mutate(Continent = ifelse(CNT %in% EUROPE, 'Europe', ifelse(CNT %in% ASIA, 'Asia', ifelse(CNT %in% AUSTRALIA, 'Australia\nOceania', ifelse(CNT %in% SOUTH_AMERICA, 'South America', ifelse(CNT %in% AFRICA, 'Africa', 'North America'))))))

df2 <- Continents %>%
  filter(!is.na(IC006Q01TA))

df1 <-  Continents %>%
  group_by(Continent, IC006Q01TA) %>%
  count() %>%
    filter(!is.na(IC006Q01TA)) %>%
    mutate(Percentage = 100*n/table(df2$Continent)[[Continent]]) 



ggplot(df1, aes(fill=IC006Q01TA, y=Percentage, x=Continent)) + 
  geom_bar(position="stack", stat="identity") +
  theme_bw() +
  theme( panel.border = element_blank(),  
         panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.line.y = element_blank(),
         text = element_text(size = 11, family="Short", colour = "black")) +
  coord_flip() +
  scale_fill_continuous(name = "Time", labels = c("No use","< 0,5h","< 1h","< 2h","< 4h","< 6h","> 6h")) +
  labs(title="How long do you use the Internet outside of school during the typical weekday?")

