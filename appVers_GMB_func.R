#Find min and max dates
minDate <- min(df$created_dt)
maxDate <- max(df$created_dt)

minDate <- format.Date(minDate, "%m/%d/%y"); minDate
maxDate <- format.Date(maxDate, "%m/%d/%y"); maxDate

platGMB_title <- paste("GMB by Platform \n From", minDate,"to", maxDate); platGMB_title

#simple bar plot of GMB by platform
platGMB <- ggplot(plat, aes(x = Platform, y = gmb))
platGMB_bar <- platGMB + geom_bar(stat="identity"); platGMB_bar
platGMB_bar <- platGMB_bar + labs(title = platGMB_title, 
                                  x = "Platform",
                                  y = "GMB/day"); platGMB_bar

platGMB_bar <- platGMB_bar + theme_minimal(); platGMB_bar
platGMB_bar <- platGMB_bar + theme(plot.title = element_text(size=14, face="bold", vjust=1)); platGMB_bar
platGMB_bar <- platGMB_bar + scale_y_continuous(breaks= pretty_breaks(10),labels=dollar_format()); platGMB_bar

platGMB_bar <- platGMB_bar + geom_text(label=plat$gmb, vjust=-1); platGMB_bar
#show percentages


#appendix
pie <- ggplot(plat, aes(x = 1, y=gmb, fill = Platform)) + geom_bar(stat="identity") + coord_polar(theta="y"); pie