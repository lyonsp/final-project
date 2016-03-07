library(plotly)
library(dplyr)
our_only_2012 <- filter(only_2012, grepl("BURGLARY|LIQUOR VIOLATIONS|
                                         ASSAULTS|ROBBERY|NARCOTICS COMPLAINTS|
                                         THREATS, HARASSMENT|HOMICIDE|WEAPONS CALLS|
                                         CAR PROWL|SHOPLIFTING|PROSTITUTION",
                                         Event.Clearance.Group))

select_month <- function(month) {
  sorted_our_2012 <- our_only_2012 %>% group_by(Event.Clearance.Group) %>%
                    filter(grepl(month, Event.Clearance.Date)) %>% 
                    summarise(total_calls = n()) %>% arrange(desc(total_calls))
summary_bar <- plot_ly(sorted_our_2012, type = "bar",
                        x = c(sorted_our_2012$Event.Clearance.Group),
                        y = c(sorted_our_2012$total_calls)) %>% 
  layout(title = "Call Type", 
         xaxis = list(title = "Call Type"),
         yaxis = list(title = "Total Calls")) %>% 
return()
}