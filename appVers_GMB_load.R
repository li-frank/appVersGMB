#setwd("C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Rproj/GMB_appVers")

#install.packages('RJDBC')
#install.packages('plyr')
#install.packages("C:/Users/frankli/Downloads/ebaytd_1.1.tar.gz", repos = NULL, type = "source", lib="C:/Program Files/R/R-3.1.1/library")

############################################
c <- teradataConnect()

sqlPath <- 'C:/Users/frankli/Dropbox (eBayMob&Eng)/FrankL/Rproj/appVersGMB/GMB_appVers_Date.sql'
sqlQuery <- paste(readLines(sqlPath), collapse=" ")
df <- dbGetQuery(c,sqlQuery)
df2 <- df