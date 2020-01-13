library(fmsb)
library("intsvy")
library("dplyr")
library("ggplot2")
library("tidyr")
library(ggalt)

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

low_avail_students <- students %>%
  filter(CNT %in% low_avail[[1]])
high_avail_students <- students %>%
  filter(CNT %in% high_avail[[1]])


low_availMATH <- pisa2015.mean.pv(pvlabel = "MATH", data = low_avail_students )
high_availMATH <- pisa2015.mean.pv(pvlabel = "MATH", data = high_avail_students)

low_availREAD <- pisa2015.mean.pv(pvlabel = "READ", data = low_avail_students)
high_availREAD <- pisa2015.mean.pv(pvlabel = "READ", data = high_avail_students)

low_availSCIE <- pisa2015.mean.pv(pvlabel = "SCIE", data = low_avail_students)
high_availSCIE <- pisa2015.mean.pv(pvlabel = "SCIE", data = high_avail_students)

low_high <- data.frame(rbind(c('SCIE', low_availSCIE[["Mean"]], high_availSCIE[["Mean"]]),
  c('MATH', low_availMATH[['Mean']], high_availMATH[['Mean']]),
  c('READ', low_availREAD[['Mean']], high_availREAD[['Mean']])))
low_high[[1]]  <- as.character(low_high[[1]])
low_high[[2]]  <- as.numeric(as.vector(low_high[[2]]))
low_high[[3]]  <- as.numeric(as.vector(low_high[[3]]))
colnames(low_high) <- c( 'subject', 'low_availability', 'high_availability')


df2 <- gather(low_high, group, value)[-(1:3),]
df2 <- cbind(df2, rep(c("SCIE", "MATH", "READ"), 2))
colnames(df2)[3] <- "subject"
df2$score <- as.numeric(as.vector(df2[[2]]))

ggplot(low_high, aes(y = subject)) +
   geom_dumbbell(aes( x = low_availability, xend = high_availability),
                 size_x = 7,
                 size_xend = 7,
                 colour_x = "#ffcc00", 
                 colour_xend = "#0066ff", 
                 show.legend = TRUE) +
  xlim(c(480, 515)) +
  geom_text(color="black", size=6, hjust=1.25,
            aes(x=low_availability, label=low_availability)) +
  geom_text(color="black", size=6, hjust=-0.3,
           aes(x=high_availability, label=high_availability)) +
  #geom_text(color = "black", size = 3.5, vjust = -0.4,
   #         aes(x = (low_availability+high_availability)/2, label = paste0("+", round(high_availability - low_availability, 2)))) +
  ylab("Dziedzina") +
  xlab("Średni wynik") +
  scale_y_discrete(breaks = c("MATH", "READ", "SCIE"), labels = c("Matematyka", "Czytanie", "Przyroda")) +
  geom_point(data = df2, aes(x=score, color = group), size = 5) +
  scale_color_manual(name = "Państwa o:", values = c("#0066ff", "#ffcc00"), labels = c("wysokiej\ndostępności", "niskiej\ndostępności")) +
  theme_bw() +
  theme(axis.text.y = element_text(angle = 40)) +
  labs(subtitle = "Średnie wyniki uczniów z podziałem na kraje o wysokiej i niskiej\ndostępności oprogramowania edukacyjnego",
       title = "Jak wpływa dostępność oprogramowania edukacyjnego na wyniki z różnych dziedzin?") 
  
  


###