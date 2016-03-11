library(plotly)
library(dplyr)

# Reads in the only_2012 CSV file
only_2012 <- read.csv("data/only_2012.csv")

# Filters out the only_2012 data to only the 911 Calls are grouped in the following event categories
our_only_2012 <- filter(only_2012, grepl("BURGLARY|LIQUOR VIOLATIONS|
                                        ASSAULTS|ROBBERY|NARCOTICS COMPLAINTS|
                                         THREATS, HARASSMENT|HOMICIDE|WEAPONS CALLS|
                                         CAR PROWL|SHOPLIFTING|PROSTITUTION",
                                         Event.Clearance.Group))

# A function that takes in a month as a parameter, and filters the our_only_2012 dataset to the 911 calls that occurred during that specific month, and summarises the number of 911 calls that occured for each event group/category
select_month <- function(month) {
  sorted_our_2012 <- our_only_2012 %>% group_by(Event.Clearance.Group) %>%
                    filter(grepl(month, Event.Clearance.Date)) %>% 
                    summarise(total_calls = n()) %>% arrange(desc(total_calls))

# Creates a histogram that compares the call type from the groups in the our_only_2012 dataset to the number of calls for that call group (can be either sorted by month or total for the year)
summary_bar <- plot_ly(sorted_our_2012, type = "bar",
                        x = (sorted_our_2012$Event.Clearance.Group),
                        y = (sorted_our_2012$total_calls)) %>% 
  layout(title = "Total Calls per Call Type for Given Month", 
         xaxis = list(title = "Call Type"),
         yaxis = list(title = "Total Calls"), 
         margin = list("b" = 100)) %>% 
return()
}

