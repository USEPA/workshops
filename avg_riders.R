library(dplyr)
rides <- read.csv("../may_2012_ridership.csv")
station_rides<-rides %>% 
  group_by(Ent.Station) %>%
  summarize(avg_wkday = sum(Riders..Average.Weekday..May.2012))%>%
  data.frame()
write.csv(station_rides,"../station_rides.csv")
