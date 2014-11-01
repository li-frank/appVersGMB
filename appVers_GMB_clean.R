#see unique platforms
unique(df$Platform)

#see min & max days
df$created_dt <- as.Date(df$created_dt)
minDate <- min(df$created_dt)
maxDate <- max(df$created_dt)

days <- as.numeric(maxDate-minDate+1); days

#last 30 days' platform summary
plat <- ddply(df,.(Platform),summarize,gmb=sum(gmb_plan)/days)
##sort by GMB
plat$Platform <-factor(plat$Platform, levels=plat[order(plat$gmb,decreasing=TRUE),"Platform"])

#platforms over time
platDate <- ddply(df,.(Platform, created_dt),summarize,gmb=sum(gmb_plan))
platDateShare <- ddply(platDate,"created_dt",transform,gmbDateShare=gmb/sum(gmb))
##sort Platform by GMB
platDateShare <- platDateShare[with(platDateShare,order(gmb)),]
##sort Platform factor by GMB (for legend)
platDateShare$Platform <-factor(platDateShare$Platform, levels=platDateShare[order(platDateShare$gmb,decreasing=TRUE),"Platform"])

#app verions over time (only iPhone & Android)
appVers <- ddply(df,.(Platform,appVersion,created_dt),summarize,gmb=sum(gmb_plan))
appVersShare <- ddply(appVers,.(created_dt,Platform),transform,gmbDateShare=gmb/sum(gmb))
##sort
appVersShare <- appVersShare[with(appVersShare,order(gmb)),]
appVersShare$Platform <-factor(appVersShare$Platform, levels=appVersShare[order(appVersShare$gmb,decreasing=TRUE),"Platform"])
##separate sets for iPhone and Android
iphoneVersShare <- appVersShare[appVersShare$Platform=="iPhone App",]
androidVersShare <- appVersShare[appVersShare$Platform=="Android App",]
##only use top cumulative GMB versions
###find top versions
iphoneVersCum <- ddply(iphoneVersShare,.(appVersion),summarize,gmb=sum(gmb))
androidVersCum <- ddply(androidVersShare,.(appVersion),summarize,gmb=sum(gmb))
topiphoneVers <- iphoneVersCum[rev(order(iphoneVersCum$gmb)),"appVersion"][1:8]; topiphoneVers
topandroidVers <- androidVersCum[rev(order(androidVersCum$gmb)),"appVersion"][1:8]; topandroidVers
###filter for top 10 versions
iphoneVersShare <- iphoneVersShare[iphoneVersShare$appVersion %in% topiphoneVers,]
androidVersShare <- androidVersShare[androidVersShare$appVersion %in% topandroidVers,]

##############################
#app versions over time
platDate_AppVers <- ddply(df,.(Platform, created_dt, appVersion),summarize,gmb=sum(gmb_plan))

#platform over time & country
platDate_Country <- ddply(df,.(Platform, created_dt, buyer_country),summarize,gmb=sum(gmb_plan))

#app & platform versions over time & country
platDate_appVersCountry <- ddply(df,.(Platform, created_dt, appVersion, buyer_country),summarize,gmb=sum(gmb_plan))

##iPhone

##Android