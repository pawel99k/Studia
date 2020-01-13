options(stringsAsFactors = FALSE)

source("xmluj.R")

Users <- xmluj("bitcoin.stackexchange.com/Users.xml")
#kraje uzytkownikow
library(stringi)

Users[,Location]

unlist(read.csv("bitcoin_analysis/ext_data/countries.txt", header = F)) -> kraje
kraje[kraje == "Ireland {Republic}"] <- "Ireland"
kraje[length(kraje)+1] <- "Hong Kong"
unlist(read.csv("bitcoin_analysis/ext_data/50_us_states_two_letter_abbreviations.csv", header = F)) -> skroty
unlist(read.csv("bitcoin_analysis/ext_data/50_us_state_names.csv", header = F)) -> stany


stri_extract_all_regex(Users[,Location], "[^,]+$") -> lokaliz


unlist(lokaliz) -> lokaliz
stri_replace_all_regex(lokaliz, "^ ", "") -> lokaliz

lokaliz[lokaliz %in% skroty] <- "United States"
lokaliz[lokaliz=="UK"] <- "United Kingdom"
lokaliz[lokaliz %in% stany] <- "United States"
lokaliz[lokaliz == "Russia"] <- "Russian Federation"
lokaliz[lokaliz == "USA"] <- "United States"
lokaliz[lokaliz == "Deutschland"] <- "Germany"
lokaliz[lokaliz == "Brasil"] <- "Brazil"
lokaliz[lokaliz == "Italia"] <- "Italy"
lokaliz[lokaliz == "South Korea"] <- "Korea South"
lokaliz[lokaliz == "The Netherlands"] <- "Netherlands"
lokaliz[lokaliz == "London"] <- "United Kingdom"
lokaliz[lokaliz == "Polska"] <- "Poland"
lokaliz[lokaliz == "England"] <- "United Kingdom"
lokaliz[lokaliz == "Scotland"] <- "United Kingdom"
lokaliz[lokaliz == "TĂĽrkiye"] <- "Turkey"
lokaliz[lokaliz == "EspaĂ±a" ] <- "Spain"
lokaliz[lokaliz == "Bangalore"] <- "India"
lokaliz[lokaliz == "US"] <- "United States"
lokaliz[lokaliz == "MĂ©xico"] <- "Mexico"
lokaliz[lokaliz == "Moscow"] <- "Russian Federation"
lokaliz[lokaliz == "San Francisco Bay Area"] <- "United States"
lokaliz[lokaliz == "San Francisco"] <- "United States"
lokaliz[lokaliz == "Paris"] <- "France"
lokaliz[lokaliz == "Berlin"] <- "Germany"
lokaliz[lokaliz == "Scotland"] <- "United Kingdom"
lokaliz[lokaliz == "Czechia"] <- "Czech Republic"
lokaliz[lokaliz == "Ă–sterreich"] <- "Austria"
lokaliz[lokaliz == "New Delhi"] <- "India"
lokaliz[lokaliz == "Delhi"] <- "India"
lokaliz[lokaliz == "Nederland"] <- "Netherlands"
lokaliz[lokaliz == "Istanbul"] <- "Turkey"
lokaliz[lokaliz == "Chennai"] <- "India"
lokaliz[lokaliz == "San Francisco"] <- "United States"
lokaliz[lokaliz == "Schweiz"] <- "Switzerland"
lokaliz[lokaliz == "DC"] <- "United States"
lokaliz[lokaliz == "Dubai - United Arab Emirates"] <- "United Arab Emirates"
lokaliz[lokaliz == "Norge"] <- "Norway"
lokaliz[lokaliz == "Bosnia and Herzegovina"] <- "Bosnia Herzegovina"
lokaliz[lokaliz == "New York City"] <- "United States"
lokaliz[lokaliz == "Bangkok Thailand"] <- "Thailand"
lokaliz[lokaliz == "Viá»‡t Nam"] <- "Vietnam"
lokaliz[lokaliz == "NYC"] <- "United States"
lokaliz[lokaliz == "Viá»‡t Nam"] <- "Vietnam"
lokaliz[lokaliz == "Toronto"] <- "Canada"
lokaliz[lokaliz == "Mumbai"] <- "India"
lokaliz[lokaliz == "BelgiĂ«"] <- "Belgium"
lokaliz[lokaliz == "Belgrade"] <- "Serbia"
lokaliz[lokaliz == "Los Angeles"] <- "United States"
lokaliz[lokaliz == "Silicon Valley"] <- "United States"
lokaliz[lokaliz == "ÄŚesko"] <- "Czech Republic"
lokaliz[lokaliz == "Chicago"] <- "United States"
lokaliz[lokaliz == "Danmark"] <- "Denmark"
lokaliz[lokaliz == "Hyderabad"] <- "India"
lokaliz[lokaliz == "Montreal"] <- "Canada"
lokaliz[lokaliz == "Tehran"] <- "Iran"



head(sort(table(lokaliz[!is.na(lokaliz) & !lokaliz %in% kraje & lokaliz!=""]), decreasing = TRUE), 10) #najpopularniejsze niedopasowane wyniki


Users[unlist(stri_detect_regex(Users[,Location], "Europe")), Location] -> europe
sort(table(europe))  #jedynie z pojedynczych mozna wyciagnac kraj

Users[unlist(stri_detect_regex(Users[,Location], "Earth")), Location]  #brak danych

Users[unlist(stri_detect_regex(Users[,Location], "\u0081")), Location] -> szlaczki #takich stringów jest niewiele, nie wplyna znaczaco na wynik

sort(table(lokaliz[lokaliz %in% kraje]))

length(lokaliz[lokaliz %in% kraje])/nrow(Users)
#spora liczba braku danych, mimo ze wsrod pierwszych 1000 uzytk. wynosi mniej -  56%



write.csv(sort(table(lokaliz[lokaliz %in% kraje])), "bitcoin_analysis/users_countries.csv")
