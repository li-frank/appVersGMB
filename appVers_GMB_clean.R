#see unique platforms
unique(df$Platform)

# #change gmb to integer
# typeof(df$gmb)
# df$gmb <- as.integer(df$gmb)

#see min & max days
minDate <- min(df$created_dt)
maxDate <- max(df$created_dt)

minDate <- as.Date(minDate, "%Y-%m-%d"); minDate
maxDate <- as.Date(maxDate, "%Y-%m-%d"); maxDate

days <- as.numeric(maxDate-minDate+1); days

#last 30 days' platform summary
plat <- ddply(df,.(Platform),summarize,gmb=sum(gmb_plan)/days)
##sort by GMB descending
plat$Platform <- factor(plat$Platform, levels = plat$Platform[order(plat$gmb, decreasing=TRUE)])

#platforms over time
platDate <- ddply(df,.(Platform, created_dt),summarize,gmb=sum(gmb_plan))

#app versions over time
platDate_AppVers <- ddply(df,.(Platform, created_dt, appVersion),summarize,gmb=sum(gmb_plan))

#platform over time & country
platDate_Country <- ddply(df,.(Platform, created_dt, buyer_country),summarize,gmb=sum(gmb_plan))

#app & platform versions over time & country
platDate_appVersCountry <- ddply(df,.(Platform, created_dt, appVersion, buyer_country),summarize,gmb=sum(gmb_plan))

##iPhone

##Android