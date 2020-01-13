library(ggplot2)
library(dplyr)
library(maps)
library(mapproj)

data_of_all_questions <-  get_data_of_questions(c('ST', 011))

some_eu_countries_alpha3 <- c('PRT', 'ESP', 'FRA', 'CHE', 'DEU', 'AUT', 'BEL', 'GBR', 'NLD', 'DNK', 'POL', 'ITA', 'HRV', 'SVN', 'HUN', 'SVK', 'CZE', 'NOR', 'SWE', 'FIN', 'EST', 'LVA', 'LTU', 'BLR', 'UKR', 'MDA', 'ROU', 'BIH', 'SRB', 'MNE', 'MKD', 'BGR', 'ALB', 'GRC', 'UNK', 'LUX')

data_of_all_questions <- filter(data_of_all_questions, CNT %in% some_eu_countries_alpha3) %>% select(CNT, ST011Q05TA) %>% na.omit() %>% group_by(CNT, ST011Q05TA) %>% summarise(count = n())
temp_data <- cbind(unique(data_of_all_questions$CNT), data_of_all_questions[seq(1, nrow(data_of_all_questions), 2), 3]/(data_of_all_questions[seq(1, nrow(data_of_all_questions), 2), 3]+data_of_all_questions[seq(2, nrow(data_of_all_questions), 2), 3])*100)

names(temp_data) <- c('alpha3', 'fraction')

NAs <- as.data.frame(rbind(c('UKR', NA), c('BLR', NA), c('SRB', NA), c('BIH', NA), c('ALB', NA), c('UNK', NA)))
names(NAs) <- c('alpha3', 'fraction')
temp_data <- rbind(temp_data, NAs)

some_eu_countries <- c("Portugal", "Spain", "France", "Switzerland", "Germany", "Austria", "Belgium", "UK", "Netherlands", "Denmark", "Poland", "Italy", "Croatia", "Slovenia", "Hungary", "Slovakia", "Czech Republic", "Norway", "Sweden", "Finland", "Estonia", "Latvia", "Lithuania", "Belarus", "Ukraine", "Moldova", "Romania", "Bosnia and Herzegovina", "Serbia", "Montenegro", "Macedonia", "Bulgaria", "Albania", "Greece", "Kosovo", "Luxembourg")

final_data <- inner_join(as.data.frame(cbind(some_eu_countries, some_eu_countries_alpha3)), temp_data, by = c('some_eu_countries_alpha3' = 'alpha3'))

names(final_data) <- c('region', 'alpha3', 'fraction')

some_eu_maps <- map_data("world", region = some_eu_countries)
some_eu_maps <- filter(some_eu_maps, subregion != "Svalbard" | is.na(subregion))

region_lab_data <- some_eu_maps %>% group_by(region) %>% summarise(long = mean(long), lat = mean(lat))
region_lab_data <- inner_join(as.data.frame(cbind(some_eu_countries, some_eu_countries_alpha3)), region_lab_data, by = c('some_eu_countries' = 'region'))
region_lab_data[some_eu_countries_alpha3 == 'PRT', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'PRT', 3:4]) + c(-0.2,0)
region_lab_data[some_eu_countries_alpha3 == 'FRA', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'FRA', 3:4]) + c(0,0.7)
region_lab_data[some_eu_countries_alpha3 == 'GBR', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'GBR', 3:4]) + c(2.5,-3)
region_lab_data[some_eu_countries_alpha3 == 'BEL', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'BEL', 3:4]) + c(0,0.1)
region_lab_data[some_eu_countries_alpha3 == 'NLD', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'NLD', 3:4]) + c(0,1)
region_lab_data[some_eu_countries_alpha3 == 'CHE', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'CHE', 3:4]) + c(0,0.2)
region_lab_data[some_eu_countries_alpha3 == 'DNK', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'DNK', 3:4]) + c(-1.5,0.3)
region_lab_data[some_eu_countries_alpha3 == 'ITA', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'ITA', 3:4]) + c(0.8,0.8)
region_lab_data[some_eu_countries_alpha3 == 'AUT', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'AUT', 3:4]) + c(1,0)
region_lab_data[some_eu_countries_alpha3 == 'CZE', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'CZE', 3:4]) + c(0,-0.2)
region_lab_data[some_eu_countries_alpha3 == 'POL', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'POL', 3:4]) + c(0.2,1)
region_lab_data[some_eu_countries_alpha3 == 'EST', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'EST', 3:4]) + c(1.3,0.3)
region_lab_data[some_eu_countries_alpha3 == 'NOR', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'NOR', 3:4]) + c(-6,-5)
region_lab_data[some_eu_countries_alpha3 == 'SWE', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'SWE', 3:4]) + c(-3.4,-3.4)
region_lab_data[some_eu_countries_alpha3 == 'FIN', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'FIN', 3:4]) + c(2,-1)
region_lab_data[some_eu_countries_alpha3 == 'HRV', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'HRV', 3:4]) + c(0.4,1)
region_lab_data[some_eu_countries_alpha3 == 'GRC', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'GRC', 3:4]) + c(-2.3,1.5)
region_lab_data[some_eu_countries_alpha3 == 'MDA', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'MDA', 3:4]) + c(0.2,0)
region_lab_data[some_eu_countries_alpha3 == 'LUX', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'LUX', 3:4]) + c(0,0.1)
region_lab_data[some_eu_countries_alpha3 == 'ESP', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'ESP', 3:4]) + c(-0.5,-0.2)
region_lab_data[some_eu_countries_alpha3 == 'NLD', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'NLD', 3:4]) + c(0.3,-0.8)
region_lab_data[some_eu_countries_alpha3 == 'UKR', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'UKR', 3:4]) + c(0,1)
region_lab_data[some_eu_countries_alpha3 == 'UNK', 3:4] <- as.numeric(region_lab_data[some_eu_countries_alpha3 == 'UNK', 3:4]) + c(0.2,-0.1)

plot_data <- inner_join(final_data, some_eu_maps, by = "region")
plot_data$fraction <- as.numeric(plot_data$fraction)

ggplot(plot_data, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = fraction)) +
  geom_polygon(aes(group = group), color = 'white', fill = NA, size = 0.2) +
  geom_text(aes(label = some_eu_countries_alpha3), data = region_lab_data,size = 3, hjust = 0.5, color = 'black') +
  labs(title = "Czy masz dostęp do oprogramowania edukacyjnego?", subtitle = "Procent pozytywnych odpowiedzi względem państwa", fill = "Skala") +
  scale_fill_distiller(type = 'seq', palette = 'Greens', direction = 1) +
  #scale_fill_viridis_c(option = "E", direction = 1) +
  theme_void() +
  theme(plot.caption = element_text(hjust = 0, size = 10)) +
  coord_map()

