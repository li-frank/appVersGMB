#Find min and max dates
minDate <- min(df$created_dt)
maxDate <- max(df$created_dt)

#simple bar plot of GMB by platform
platGMB_bar <- ggplot(plat, aes(x = factor(plat$Platform), y = plat$gmb)) 
platGMB_bar <- platGMB_bar + geom_bar(stat="identity")
platGMB_bar <- platGMB_bar + xlab("Platform")+ ylab("GMB")
platGMB_bar

#sort bars
#show percentages
