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
questions_IC <- c("IC", 08)
data_of_videogames <-  get_data_of_questions(questions_IC)[, 1:6]
questions_ST <- c("ST", 34)
data_of_loneliness <- get_data_of_questions(questions_ST)[,c(-5, -6, -7, -8, -9)]
data_of_all_questions <- left_join(data_of_videogames, data_of_loneliness, by = c("CNT", "CNTSCHID", "CNTSTUID", "LANGTEST_QQQ"))


groupeddata <- data_of_all_questions %>%
  filter(!is.na(IC008Q01TA)) %>%
  mutate(Games = IC008Q01TA) %>%
  filter(!is.na(Games) & !is.na(ST034Q06TA)) %>%
  group_by(ST034Q06TA, Games) %>%
  summarise(count = n()) %>%
  mutate(perc=count/sum(count))

groupeddata$Games <- as.factor(groupeddata$Games)

ggplot(groupeddata, aes(fill=ST034Q06TA, y=perc*100, x=Games)) + 
  geom_bar(position="fill", stat="identity") +
  theme_bw() +
  xlab("How often do you play video games (singleplayer)?") +
  theme( panel.border = element_blank(),  
         panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.line.y = element_blank(),
         axis.title.x = element_blank(),
         legend.title.align = 0.1,
         legend.title = element_text(size = 9),
         legend.text = element_text(size = 6),
         text = element_text(size = 11, family="Short", colour = "black")) +
  coord_flip() +
  scale_x_discrete(breaks = c('1', '2', '3', '4', '5'),  labels = c("Never or\nhardly ever", "One or twice\na month", "One or\ntwice a week", "Almost\nevery day", "Every day")) +
  scale_fill_gradient2(name = "Do you feel\nlonely at school?", labels = c("Strongly\nagree", "Agree","Disagree","Strongly\ndisagree"), low = "#99000d", high = "#fee5d9", mid = "#fb6a4a", midpoint = 2.5) +
  scale_y_continuous(labels = c("0%", "25%", "50%", "75%", "100%")) +
  labs(title="Do you feel lonely at school?")

