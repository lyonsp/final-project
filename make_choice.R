library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

make_choice <- function(choice) {
  newschoolData <- schoolData %>% select_(choice)
  return(newschoolData)
}

