#simple bar plot of GMB by platform
platGMB_bar <- ggplot(platGMB, aes(x = factor(platGMB$Platform), y = platGMB$gmb)) 
platGMB_bar <- platGMB_bar + geom_bar(stat="identity")
#sort bars
#show percentages
