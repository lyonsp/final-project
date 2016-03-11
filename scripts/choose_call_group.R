library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

# A function that selects a group within our dataset of 911 Calls in 2012, and filters the data to show only the calls that are categorized in that group
choose_call_group <- function(group) {
  chosen_group <- only_2012 %>% filter(Event.Clearance.Group == group)
  return(chosen_group)
}