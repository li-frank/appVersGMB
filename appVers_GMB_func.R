#Find min and max dates
minDate <- format.Date(minDate, "%m/%d/%y"); minDate
maxDate <- format.Date(maxDate, "%m/%d/%y"); maxDate

platGMB_title <- paste("GMB by Platform \n From", minDate,"to", maxDate); platGMB_title

#bar plot of GMB by platform
platGMB <- ggplot(plat, aes(x = Platform, y = gmb/1000000))
platGMB_bar <- platGMB + geom_bar(stat="identity"); platGMB_bar
platGMB_bar <- platGMB_bar + labs(title = platGMB_title, 
                                  x = "Platform",
                                  y = "GMB/day ($MM)"); platGMB_bar
platGMB_bar <- platGMB_bar + theme_minimal(); platGMB_bar
platGMB_bar <- platGMB_bar + theme(plot.title = element_text(size=14, face="bold", vjust=1),panel.grid.major.x = element_blank()); platGMB_bar
platGMB_bar <- platGMB_bar + scale_y_continuous(breaks= pretty_breaks(8)); platGMB_bar
platGMB_bar <- platGMB_bar + geom_text(label=scales::percent(plat$gmb/sum(plat$gmb)), labels=percent_format(), vjust=-0.2); platGMB_bar

#stacked line plot of GMB by platform
platTime <- ggplot(platDate, aes(x = created_dt, y = gmb, fill = Platform, group=Platform)) +  geom_area(position = 'stack'); platTime
##remove margins from left and right
##change colors
##make %s

#appendix
pie <- ggplot(plat, aes(x = 1, y=gmb, fill = Platform)) + geom_bar(stat="identity") + coord_polar(theta="y"); pie