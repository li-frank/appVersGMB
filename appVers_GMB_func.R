#color-blind friendly palette
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

#bar plot of GMB by platform
platGMB_title <- paste("Global GMB by Platform \n", minDate,"to", maxDate); platGMB_title
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
platDate_title <- paste("Global GMB Share by Platform \n", minDate,"to", maxDate); platDate_title
platDate_stack <- ggplot(platDateShare, aes(x = created_dt, y = gmbDateShare, fill = Platform, group=Platform)) 
platDate_stack <- platDate_stack +  geom_area(position = 'stack'); platDate_stack
platDate_stack <- platDate_stack + labs(title = platDate_title, 
                                  x = "Date",
                                  y = "GMB Share (%)"); platDate_stack
platDate_stack <- platDate_stack + scale_y_continuous(breaks=pretty_breaks(), labels = percent); platDate_stack
platDate_stack <- platDate_stack + theme_minimal(); platDate_stack
platDate_stack <- platDate_stack + theme(plot.title = element_text(size=14, face="bold"),panel.grid.major.x = element_blank()); platDate_stack
platDate_stack <- platDate_stack + scale_x_date(labels = date_format("%m/%d")); platDate_stack
platDate_stack <- platDate_stack + scale_fill_manual(values=cbPalette); platDate_stack

#stacked plot: GMB by iPhone app Version
iphoneVers_title <- paste("Global iPhone App Version: GMB Share \n", minDate, "to", maxDate); iphoneVers_title
iphoneVers_stack <- ggplot(iphoneVersShare, aes(x = created_dt, y = gmbDateShare, fill = appVersion, group = appVersion))
iphoneVers_stack <- iphoneVers_stack +  geom_area(position = 'stack'); iphoneVers_stack
iphoneVers_stack <- iphoneVers_stack + labs(title = iphoneVers_title, 
                                        x = "Date",
                                        y = "GMB Share (%)"); iphoneVers_stack
iphoneVers_stack <- iphoneVers_stack + scale_y_continuous(breaks=pretty_breaks(), labels = percent); iphoneVers_stack
iphoneVers_stack <- iphoneVers_stack + theme_minimal(); iphoneVers_stack
iphoneVers_stack <- iphoneVers_stack + theme(plot.title = element_text(size=14, face="bold"),panel.grid.major.x = element_blank()); iphoneVers_stack
iphoneVers_stack <- iphoneVers_stack + scale_x_date(labels = date_format("%m/%d")); iphoneVers_stack
iphoneVers_stack <- iphoneVers_stack + scale_fill_manual(values=cbPalette); iphoneVers_stack

#stacked plot: GMB by android app Version
androidVers_title <- paste("Global Android App Version: GMB Share \n", minDate, "to", maxDate); androidVers_title
androidVers_stack <- ggplot(androidVersShare, aes(x = created_dt, y = gmbDateShare, fill = appVersion, group = appVersion))
androidVers_stack <- androidVers_stack +  geom_area(position = 'stack'); androidVers_stack
androidVers_stack <- androidVers_stack + labs(title = androidVers_title, 
                                            x = "Date",
                                            y = "GMB Share (%)"); androidVers_stack
androidVers_stack <- androidVers_stack + scale_y_continuous(breaks=pretty_breaks(), labels = percent); androidVers_stack
androidVers_stack <- androidVers_stack + theme_minimal(); androidVers_stack
androidVers_stack <- androidVers_stack + theme(plot.title = element_text(size=14, face="bold"),panel.grid.major.x = element_blank()); androidVers_stack
androidVers_stack <- androidVers_stack + scale_x_date(labels = date_format("%m/%d")); androidVers_stack
androidVers_stack <- androidVers_stack + scale_fill_manual(values=cbPalette); androidVers_stack

#appendix
pie <- ggplot(plat, aes(x = 1, y=gmb, fill = Platform)) + geom_bar(stat="identity") + coord_polar(theta="y"); pie