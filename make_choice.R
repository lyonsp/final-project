library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

# A function that takes the choice of school data we want to look at (Free Lunches, Limited English, One Parent) and selects the data column that fits the parameter entered
make_choice <- function(choice) {
  newschoolData <- schoolData %>% select_(choice)
  return(newschoolData)
}

