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
questions_IC <- c("IC", 06)
data_of_internet <-  get_data_of_questions(questions_IC)
questions_ST <- c("ST", 34)
data_of_loneliness <- get_data_of_questions(questions_ST)[,c(-5, -6, -7, -8, -9)]
data_of_all_questions <- left_join(data_of_internet, data_of_loneliness, by = c("CNT", "CNTSCHID", "CNTSTUID", "LANGTEST_QQQ"))


  groupeddata <- data_of_all_questions %>%
  filter(!is.na(IC006Q01TA) & !is.na(ST034Q06TA)) %>%
  group_by(ST034Q06TA, IC006Q01TA) %>%
  summarise(count = n()) %>%
  mutate(perc=count/sum(count))


ggplot(groupeddata, aes(fill=IC006Q01TA, y=perc*100, x=ST034Q06TA)) + 
  geom_bar(position="fill", stat="identity") +
  theme_bw() +
  xlab("Do you feel lonely at school?") +
  theme( panel.border = element_blank(),  
         panel.grid.major = element_blank(),
         panel.grid.minor = element_blank(),
         axis.line = element_line(colour = "black"),
         axis.line.y = element_blank(),
         axis.title.x = element_blank(),
         text = element_text(size = 11, family="Short", colour = "black")) +
  coord_flip() +
  scale_x_reverse(breaks = c(1, 2, 3, 4), labels = c("Strongly\nagree", "Agree", "Disagree", "Strongly\ndisagree")) +
  scale_fill_gradient2(name = "Time", labels = c("No use","< 0,5h","< 1h","< 2h","< 4h","< 6h","> 6h"), low = "#ffffb2", high = "#b10026", mid = "#fd8d3c", midpoint = 4) +
  scale_y_continuous(labels = c("0%", "25%", "50%", "75%", "100%")) +
  labs(title="How long do you use the Internet outside of school during the typical weekday?")

