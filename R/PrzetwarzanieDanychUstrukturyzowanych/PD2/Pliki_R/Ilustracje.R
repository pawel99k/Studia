#Ilustracje stworzone na potrzeby raportu

#2. ilustracja
maluj(fuzzyx, fuzzyx.l)
maluj(fuzzyx, hclust2(dist(fuzzyx)) %>% cutree(k=max(fuzzyx.l)))

#3. ilustracja

which.max(nicefinalcsv3["fuzzy",])
maluj(fuzzyx, spectral_clustering(fuzzyx, max(fuzzyx.l), round(nrow(fuzzyx)/max(fuzzyx.l)))$cluster)


#4. ilustracja

which.max(unlist(nicefinalcsv3)[unlist(nicefinalcsv3)<1])
unlist(nicefinalcsv3)[unlist(nicefinalcsv3)<1][72]

maluj(unbalance, unbalance.l)
maluj(unbalance, hclust(dist(unbalance), method="ward.D") %>% cutree(k=max(unbalance.l)))

#5. ilustracja

nicefinalcsv3["chainlink",]
maluj(chainlink, chainlink.l)
maluj(chainlink, spectral_clustering(chainlink, max(chainlink.l), 12)$cluster)

#6. ilustracja

which.min(unlist(nicefinalcsv))
unlist(nicefinalcsv)[2407]
nicefinalcsv[15,]

maluj(zigzag, zigzag.l)
maluj(zigzag, hclust(dist(scale(zigzag)), method = "median") %>% cutree(k=max(zigzag.l)))
  

