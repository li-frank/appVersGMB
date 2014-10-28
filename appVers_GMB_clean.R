#last 30 days' platform summary
platGMB <- ddply(df,.(Platform),summarize,gmb=sum(gmb_plan))

#platforms over time
platGMB_date <- ddply(df,.(Platform, created_dt),summarize,gmb=sum(gmb_plan))

#app versions over time
##iPhone

##Android