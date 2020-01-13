library("tidyr")
library("foreign")
library("intsvy")
library("dplyr")
library("ggplot2")
library("patchwork")

completeFUN <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

students <- read.spss("CY6_MS_CMB_STU_QQQ.sav", use.value.labels = TRUE, to.data.frame = TRUE)
temp <- arrange(completeFUN(students, 'ESCS'), ESCS)

temp1 <- temp[round(0*nrow(temp)):round(0.25*nrow(temp)), ]
temp1 <- pisa2015.mean.pv(pvlabel = "MATH", by = c("CNT", "ST011Q04TA"), data = temp1)

temp2 <- temp[round(0.25*nrow(temp)):round(0.75*nrow(temp)), ]
temp2 <- pisa2015.mean.pv(pvlabel = "MATH", by = c("CNT", "ST011Q04TA"), data = temp2)

temp3 <- temp[round(0.75*nrow(temp)):round(1*nrow(temp)), ]
temp3 <- pisa2015.mean.pv(pvlabel = "MATH", by = c("CNT", "ST011Q04TA"), data = temp3)

temp1 <- temp1[,c(1,2,4,5)]
temp1 %>%
  select(CNT, ST011Q04TA, Mean) %>%
  na.omit %>%
  spread(ST011Q04TA, Mean) -> temp1Wide

temp2 <- temp2[,c(1,2,4,5)]
temp2 %>%
  select(CNT, ST011Q04TA, Mean) %>%
  na.omit %>%
  spread(ST011Q04TA, Mean) -> temp2Wide

temp3 <- temp3[,c(1,2,4,5)]
temp3 %>%
  select(CNT, ST011Q04TA, Mean) %>%
  na.omit %>%
  spread(ST011Q04TA, Mean) -> temp3Wide

some_eu_countries <- c("Portugal", "Spain", "France", "Switzerland", "Germany", "Austria", "Belgium", "United Kingdom", "Netherlands", "Denmark", "Poland", "Italy", "Croatia", "Slovenia", "Hungary", "Slovakia", "Czech Republic", "Norway", "Sweden", "Finland", "Estonia", "Latvia", "Lithuania", "Belarus", "Ukraine", "Moldova", "Romania", "Bosnia and Herzegovina", "Serbia", "Montenegro", "Macedonia", "Bulgaria", "Albania", "Greece", "Kosovo", "Luxembourg")

temp1Wide$europe = ifelse(temp1Wide$CNT %in% some_eu_countries, TRUE, FALSE)
temp2Wide$europe = ifelse(temp2Wide$CNT %in% some_eu_countries, TRUE, FALSE)
temp3Wide$europe = ifelse(temp3Wide$CNT %in% some_eu_countries, TRUE, FALSE)

name1 <- filter(temp1Wide, CNT == "Poland")
name2 <- filter(temp2Wide, CNT == "Poland")
name3 <- filter(temp3Wide, CNT == "Poland")

a  <- ggplot(temp1Wide, aes(No, Yes, color = europe)) +
  geom_point() +
  scale_color_manual(values = c('black', 'blue')) +
  geom_abline(slope=1, intercept = 0) + 
  annotate("text", x = 575, y = 585, label = "Wyniki równe", size = 3.5, angle = 45 ) + # Dodane przez Pawła
  geom_point(data = name1, aes(x = No, y = Yes), color = 'red') +
  geom_text(data = name1, aes(x = No, y = Yes + 13, label = CNT), color = 'red') +
  xlim(c(300,600)) +
  ylim(c(300, 600)) +
  labs(title = "Czy dostęp do komputera ma poztywny wpływ na wyniki, niezależnie od zamożności?",
       subtitle = "Średnie wyniki z testu z matematyki ubogich uczniów,\nwzględem kraju i dostępu") +
  xlab("Średni wynik studentów bez dostępu") +
  ylab("Średni wynik studentów z dostępem") +
  theme_bw() +
  theme(
    plot.caption = element_text(hjust = 0, size = 10),
    aspect.ratio = 1,
    legend.position = 'none'
  )

b <- ggplot(temp2Wide, aes(No, Yes, color = europe)) +
  geom_point() +
  scale_color_manual(values = c('black', 'blue')) +
  geom_abline(slope=1, intercept = 0) + 
  annotate("text", x = 575, y = 585, label = "Wyniki równe", size = 3.5, angle = 45 ) + # Dodane przez Pawła
  geom_point(data = name2, aes(x = No, y = Yes), color = 'red') +
  geom_text(data = name2, aes(x = No, y = Yes + 10, label = CNT), color = 'red') +
  xlim(c(300,600)) +
  ylim(c(300, 600)) +
  labs(title = "", subtitle = "Średnie wyniki z testu z matematyki średnio zamożnych uczniów,\nwzględem kraju i dostępu") +
  xlab("Średni wynik studentów bez dostępu") +
  ylab("") +
  theme_bw() +
  theme(
    plot.caption = element_text(hjust = 0, size = 10),
    aspect.ratio = 1,
    legend.position = 'none'
  )

c <- ggplot(temp3Wide, aes(No, Yes, color = europe)) +
  geom_point() +
  scale_color_manual(values = c('black', 'blue')) +
  geom_abline(slope=1, intercept = 0) + 
  annotate("text", x = 575, y = 585, label = "Wyniki równe", size = 3.5, angle = 45 ) + # Dodane przez Pawła
  geom_point(data = name3, aes(x = No, y = Yes), color = 'red') +
  geom_text(data = name3, aes(x = No, y = Yes - 10, label = CNT), color = 'red') +
  xlim(c(300,600)) +
  ylim(c(300, 600)) +
  labs(title = "", subtitle = "Średnie wyniki z testu z matematyki zamożnych uczniów,\nwzględem kraju i dostępu", caption = "Państwa europejskie wyróźniono niebieskim kolorem") +
  xlab("Średni wynik studentów bez dostępu") +
  ylab("") +
  theme_bw() +
  theme(
    plot.caption = element_text(hjust = 1, size = 10, color = "blue"),
    aspect.ratio = 1,
    legend.position = 'none'
  )

a + b + c

