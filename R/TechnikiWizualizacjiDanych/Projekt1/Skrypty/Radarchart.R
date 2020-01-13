library(fmsb)
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
completeFUN <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}
#Podział na kraje o wysokim poziomie dostepu do oprogramowania i inncyh
data_of_all_questions <-  get_data_of_questions(c('ST', 011)) 
some_eu_countries_alpha3 <- c('PRT', 'ESP', 'FRA', 'CHE', 'DEU', 'AUT', 'BEL', 'GBR', 'NLD', 'DNK', 'POL', 'ITA', 'HRV', 'SVN', 'HUN', 'SVK', 'CZE', 'NOR', 'SWE', 'FIN', 'EST', 'LVA', 'LTU', 'BLR', 'UKR', 'MDA', 'ROU', 'BIH', 'SRB', 'MNE', 'MKD', 'BGR', 'ALB', 'GRC', 'UNK', 'LUX')
data_of_all_questions <- filter(data_of_all_questions, CNT %in% some_eu_countries_alpha3) %>% select(CNT, ST011Q05TA) %>% na.omit() %>% group_by(CNT, ST011Q05TA) %>% summarise(count = n())
low_avail <- cbind(unique(data_of_all_questions$CNT), data_of_all_questions[seq(1, nrow(data_of_all_questions), 2), 3]/(data_of_all_questions[seq(1, nrow(data_of_all_questions), 2), 3]+data_of_all_questions[seq(2, nrow(data_of_all_questions), 2), 3])*100) %>% arrange(count) %>% slice(1:(nrow(data_of_all_questions)/4))
high_avail <- cbind(unique(data_of_all_questions$CNT), data_of_all_questions[seq(1, nrow(data_of_all_questions), 2), 3]/(data_of_all_questions[seq(1, nrow(data_of_all_questions), 2), 3]+data_of_all_questions[seq(2, nrow(data_of_all_questions), 2), 3])*100) %>% arrange(count) %>% slice(((nrow(data_of_all_questions)/4)+1):(nrow(data_of_all_questions)/2))


COUNTRIES <- unique(students$CNT)
EUROPE <- COUNTRIES[c(1, 4, 5, 7, 13, 14, 15, 17, 18, 19, 21, 22, 24, 25, 27, 29, 33, 35, 36, 37, 39, 41, 42, 43, 45, 47, 48, 50, 51, 53, 55, 56, 57, 58, 64, 65, 68)]
europeanstudents <- students %>%
  filter(CNT %in% EUROPE)
polishstudents <- europeanstudents %>%
  filter(CNT=='POL')

europeancomplete <- europeanstudents
polishcomplete <-  polishstudents

europeanMATH <- pisa2015.mean.pv(pvlabel = "MATH", data = europeancomplete)
polandMATH <- pisa2015.mean.pv(pvlabel = "MATH", data = polishcomplete)

europeanREAD <- pisa2015.mean.pv(pvlabel = "READ", data = europeancomplete)
polandREAD <- pisa2015.mean.pv(pvlabel = "READ", data = polishcomplete)

europeanSCIE <- pisa2015.mean.pv(pvlabel = "SCIE", data = europeancomplete)
polandSCIE <- pisa2015.mean.pv(pvlabel = "SCIE", data = polishcomplete)

europepoland <- data.frame(rbind(c('SCIE', europeanSCIE[["Mean"]], polandSCIE[["Mean"]]),
  c('MATH', europeanMATH[['Mean']], polandMATH[['Mean']]),
  c('READ', europeanREAD[['Mean']], polandREAD[['Mean']])))
colnames(europepoland) <- c('Factor', 'Europe', 'Poland')

questions_IC <- c("IC",2, 6, 8, 11)
data_of_all_questions <-  get_data_of_questions(questions_IC)

other <- data_of_all_questions %>%
  filter(CNT %in% EUROPE) %>%
  select(c(CNT, CNTSCHID, CNTSTUID, LANGTEST_QQQ, IC002Q01NA, IC006Q01TA, IC008Q01TA, IC011Q01TA)) %>%
  completeFUN(c('IC002Q01NA', 'IC006Q01TA', 'IC008Q01TA', 'IC011Q01TA')) %>%
  summarise(firstage = mean(IC002Q01NA), internet = mean(IC006Q01TA), singleplayer = mean(IC008Q01TA), chatting = mean(IC011Q01TA))

otherpoland <- data_of_all_questions %>%
  filter(CNT =="POL") %>%
  select(c(CNT, CNTSCHID, CNTSTUID, LANGTEST_QQQ, IC002Q01NA, IC006Q01TA, IC008Q01TA, IC011Q01TA)) %>%
  completeFUN(c('IC002Q01NA', 'IC006Q01TA', 'IC008Q01TA', 'IC011Q01TA')) %>%
  summarise(firstage = mean(IC002Q01NA), internet = mean(IC006Q01TA), singleplayer = mean(IC008Q01TA), chatting = mean(IC011Q01TA))

europepoland <- data.frame(rbind(rbind(c('SCIE', europeanSCIE[["Mean"]], polandSCIE[["Mean"]]),
            c('MATH', europeanMATH[['Mean']], polandMATH[['Mean']]),
            c('READ', europeanREAD[['Mean']], polandREAD[['Mean']])),
       cbind(colnames(other), as.numeric(other[1,]), as.numeric(otherpoland[1,]))))
colnames(europepoland) <- c('factor', 'europe', 'poland')
europepoland[,2] <- as.numeric(europepoland[,2])
europepoland[,3] <- as.numeric(europepoland[,3])

europepoland %>%
  mutate(polrel = poland/europe) -> last
  
toradar <- as.data.frame(matrix(pull(last, 4), nrow = 1))
colnames(toradar) <- pull(europepoland, 1)
toradar[3,] <- toradar[1,]
toradar[1,] <- rep(1.2, 7)
toradar[2,] <- rep(0.8, 7)


radarchart(toradar)
