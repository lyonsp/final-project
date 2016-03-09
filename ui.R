library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

shinyUI(navbarPage("Welcome",
                   tabPanel("Intro",
                            includeMarkdown("testingOut.Rmd")),
                   tabPanel("911 Calls",
                            titlePanel("911 Call Data"),
                            sidebarPanel(helpText("Select specific type of incident."),
                                         selectInput("select", label = "Select Call Type",
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
                                      leafletOutput("mymap2"),
                                      br()),
                            sidebarPanel(helpText("View incidents for a specific month."),
                                         selectInput("selectx", label = "Select Month",
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
                            titlePanel("Seattle School Data"),
                            sidebarPanel(helpText("View schools of chosen level."),
                              selectInput("selectlevel", label = "Select School Level",
                                          choices = list("All" = "all",
                                                          "Elementary School" = "Elementary",
                                                         "Middle School" = "Middle School",
                                                         "High School" = "High School"))
                              ),
                            mainPanel("School Locations",
                                      leafletOutput("mymap"),
                                      br()),
                            
                            sidebarPanel(helpText("View percentages for selected option."),
                              selectInput("school_var", label = "Percentage Level",
                                          choices = list("Free Lunches" = "Free_Lunches",
                                                         "Limited English" = "Limited_English",
                                                         "Single Parents" = "One_Parent_Homes"
                                          )
                              )),
                              mainPanel(plotlyOutput("schoolDataChart"))
                            ),
                   
                   tabPanel("Comparison",
                            titlePanel("911 Call and Seattle School Comparison"),
                            sidebarPanel(helpText("Select specific type of incident."),
                                         selectInput("choose", label = "Select Call Type",
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
                                         helpText("View percentages for selected option."),
                            selectInput("whichtype", label = "Percentage Level",
                                        choices = list("Free Lunches" = "Percent_Free_Lunch",
                                                       "Limited English" = "Percent_Limited_English",
                                                       "Single Parents" = "Percent_One_Parent_Homes"),
                                        selected = "free"
                                        )),
                   mainPanel(leafletOutput("comparemap", height = 800, width = 900))
                   ),
                   tabPanel("Conclusion")
                            )
)
