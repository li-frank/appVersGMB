#if restart, script from just here
df<-df2

#change <NA>s to Unknown
df[is.na(df)] <- 'Unknown'

#see unique platforms
df$Platform %>% unique

#see min & max days
df$created_dt <- df$created_dt %>% as.Date; df$created_dt %>% head
minDate <- df$created_dt %>% min; minDate
maxDate <- df$created_dt %>% max; maxDate
days <- (maxDate-minDate+1) %>% as.numeric; days

#last 30 days' platform summary
#plat <- ddply(df,.(Platform),summarize,gmb=sum(gmb_plan)/days)
plat <- df %>% ddply(.(Platform),summarize,gmb=(gmb_plan %>% sum %>% `/` (days)))
#plat <- df %>% 
#  group_by(Platform) %>%
#  summarize(
#  gmb=(gmb_plan %>% sum %>% `/` (days)))

##sort by GMB
plat$Platform <-factor(plat$Platform, levels=plat[order(plat$gmb,decreasing=TRUE),"Platform"])
#plat$Platform <- plat$Platform %>% 
#  factor(levels=(plat$gmb %>% order(decreasing=TRUE) %>% plat["Platform"]))

#platforms over time (global)
platDate <- ddply(df,.(Platform, created_dt),summarize,gmb=sum(gmb_plan))
platDateShare <- ddply(platDate,"created_dt",transform,gmbDateShare=gmb/sum(gmb))
##sort Platform by GMB
platDateShare <- platDateShare[with(platDateShare,order(gmb)),]
##sort Platform factor by GMB (for legend)
platDateShare$Platform <-factor(platDateShare$Platform, levels=platDateShare[order(platDateShare$gmb,decreasing=TRUE),"Platform"])

#app versions over time
appVers <- ddply(df,.(Platform,appVersion,created_dt),summarize,gmb=sum(gmb_plan))
appVersShare <- ddply(appVers,.(created_dt,Platform),transform,gmbDateShare=gmb/sum(gmb))
##sort by GMB for filling & then legend
appVersShare <- appVersShare[with(appVersShare,order(appVersion,decreasing=TRUE)),]
appVersShare$appVersion <-factor(appVersShare$appVersion, levels=appVersShare[order(appVersShare$gmb,decreasing=TRUE),"appVersion"])

########################################################################
#use function to repeat splicing on platforms
trm <- function(toTrim){
  return(gsub(" ","",toTrim))
}

clean <- function(plat){
  plat0 <- trm(plat)
  #create version shares
  VersShare <- appVersShare[appVersShare$Platform==plat,]
  #cumulative GMB
  VersCum <- ddply(VersShare,.(appVersion),summarize,gmb=sum(gmb))
  topVers <- VersCum[rev(order(VersCum$gmb)),"appVersion"][1:8]
  VersShare <- VersShare[VersShare$appVersion %in% topVers,]
  return(VersShare)
  #paste(plat,VersCum)<-ddply(appVers,.(appVersion),summarize,gmb=sum(gmb))
}

ipadShare <- clean('iPad App')
iphoneShare <- clean('iPhone App')
androidShare <- clean('Android App')
mwebShare <- clean('Mobile Web')

#platform over time & country
platDate_Country <- ddply(df,.(Platform, created_dt, buyer_country),summarize,gmb=sum(gmb_plan))


########################################################################
# #app versions over time
# platDate_AppVers <- ddply(df,.(Platform, created_dt, appVersion),summarize,gmb=sum(gmb_plan))
# 
# 
# #app & platform versions over time & country
# platDate_appVersCountry <- ddply(df,.(Platform, created_dt, appVersion, buyer_country),summarize,gmb=sum(gmb_plan))

##iPhone

##Android