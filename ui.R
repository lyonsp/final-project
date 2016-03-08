library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

shinyUI(navbarPage("Navbar!",
                   tabPanel("Intro",
                            includeMarkdown("testingOut.Rmd")),
                   tabPanel("911 Calls",
                            titlePanel("911 Call Data"),
                            sidebarPanel(selectInput("select", label = "Select Call Type",
                                                     choices = list("Burglary" = "BURGLARY",
                                                                    "Liquor" = "LIQUOR VIOLATIONS",
                                                                    "Assaults" = "ASSAULTS",
                                                                    "Robbery" = "ROBBERY",
                                                                    "Narcotics" = "NARCOTICS COMPLAINTS", 
                                                                    "Threats" = "THREATS, HARASSMENT",
                                                                    "Homicide" = "HOMICIDE",
                                                                    "Weapons" = "WEAPONS CALLS",
                                                                    "Car Prowl" = "CAR PROWL",
                                                                    "Shoplifting" = "SHOPLIFTING",
                                                                    "Prostitution" = "PROSTITUTION"))
                                         ),
                            mainPanel("Locations of 911 Calls",
                                      leafletOutput("mymap2")),
                            sidebarPanel(selectInput("selectx", label = "Select Month",
                                                     choices = list("Total" = "2012",
                                                                    "January" = "^01/", 
                                                                    "February" = "^02/",
                                                                    "March" = "^03/",
                                                                    "April" = "^04/",
                                                                    "May" = "^05/",
                                                                    "June" = "^06/",
                                                                    "July" = "^07/",
                                                                    "August" = "^08/",
                                                                    "September" = "^09/",
                                                                    "October" = "^10/",
                                                                    "November" = "^11/",
                                                                    "December" = "^12/"),
                                                     selected = "2012")
                            ),
                            mainPanel(plotlyOutput("bargraph"))
                            ),
                   
                   tabPanel("Seattle Schools",
                            sidebarPanel(
                              selectInput("selectlevel", label = "Select School Level",
                                          choices = list("All" = "all",
                                            "Elementary School" = "Elementary",
                                                         "Middle School" = "Middle School",
                                                         "High School" = "High School"))
                              ),
                            mainPanel(leafletOutput("mymap")),
                            sidebarPanel(
                              selectInput("poop", label = "Percentage Level",
                                          choices = list("Limited English" = "nlimeng",
                                                         "Free Lunches" = "nfree",
                                                         "Single Parents" = "noneparent"
                                          )
                              )),
                              mainPanel(plotlyOutput("schoolDataChart"))
                            ),
                   
                   tabPanel("Comparison",
                            sidebarPanel(selectInput("choose", label = "Select Call Type",
                                                     choices = list("Assaults" = "ASSAULTS",
                                                                    "Burglary" = "BURGLARY",
                                                                    "Car Prowl" = "CAR PROWL",
                                                                    "Homicide" = "HOMICIDE",
                                                                    "Liquor" = "LIQUOR VIOLATIONS",
                                                                    "Narcotics" = "NARCOTICS COMPLAINTS",
                                                                    "Prostitution" = "PROSTITUTION",
                                                                    "Robbery" = "ROBBERY",
                                                                    "Shoplifting" = "SHOPLIFTING",
                                                                    "Threats" = "THREATS, HARASSMENT",
                                                                    "Weapons" = "WEAPONS CALLS"
                                                                    )),
                            
                            selectInput("whichtype", label = "Percentage Level",
                                        choices = list("Free Lunches" = "free",
                                                       "Limited English" = "limeng",
                                                       "Single Parents" = "oneparent"),
                                        selected = "free"
                                        )),
                   mainPanel(leafletOutput("comparemap"))
                   ),
                   tabPanel("Conclusion")
                            )
)