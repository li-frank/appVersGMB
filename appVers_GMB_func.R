#Find min and max dates
minDate <- min(df$created_dt)
maxDate <- max(df$created_dt)

#simple bar plot of GMB by platform
platGMB_bar <- ggplot(plat, aes(x = Platform, y = gmb)) 
platGMB_bar <- platGMB_bar + geom_bar(stat="identity")
platGMB_bar <- platGMB_bar + xlab("Platform")+ ylab("GMB") + title("GMB by Platform, Trailing 30 days")
platGMB_bar <- platGMB_bar + theme_minimal()
platGMB_bar
#show percentages
