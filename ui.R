library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)
library(shinythemes)

#Creates a navigation bar that allows a user to switch between different tabs in the Shiny App
#Each tab contains visualizations or explanations about the data
shinyUI(navbarPage(theme = shinytheme("flatly"), "Welcome",
                   #Panel contains the introduction of datasets and packages
                   tabPanel("Introduction",
                            includeMarkdown("introduction.Rmd")),
                   #Tab contains a map and chart of 911 data. Data can be manipulated with widgets on the side.
                   tabPanel("911 Calls",
                            titlePanel("911 Call Data"),
                            sidebarPanel(helpText("Select specific type of incident."),
                                         selectInput("select_call_type", label = "Select Call Type",
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
                                      leafletOutput("incident_map"),
                                      br()),
                            sidebarPanel(helpText("View incidents for a specific month."),
                                         selectInput("select_month", label = "Select Month",
                                                     choices = list("Total" = "*/12",
                                                                    "January" = "^1/", 
                                                                    "February" = "^2/",
                                                                    "March" = "^3/",
                                                                    "April" = "^4/",
                                                                    "May" = "^5/",
                                                                    "June" = "^6/",
                                                                    "July" = "^7/",
                                                                    "August" = "^8/",
                                                                    "September" = "^9/",
                                                                    "October" = "^10/",
                                                                    "November" = "^11/",
                                                                    "December" = "^12/"),
                                                     selected = "2012")
                            ),
                            mainPanel(plotlyOutput("incident_chart"))
                            ),
                   #Tab contains a map and chart of Seattle School data. 
                   #Data can be manipulated with widgets on the side.
                   tabPanel("Seattle Schools",
                            titlePanel("Seattle School Data"),
                            sidebarPanel(helpText("View schools of chosen level."),
                              selectInput("school_level", label = "Select School Level",
                                          choices = list("All" = "all",
                                                          "Elementary School" = "Elementary",
                                                         "Middle School" = "Middle School",
                                                         "High School" = "High School"))
                              ),
                            mainPanel("School Locations- Radius corresponds to percentage of selected variable",
                                      leafletOutput("school_map"),
                                      br()),
                            
                            sidebarPanel(helpText("View percentages for selected option."),
                              selectInput("school_var", label = "Percentage Level",
                                          choices = list("Free Lunches" = "Free_Lunches",
                                                         "Limited English" = "Limited_English",
                                                         "Single Parents" = "One_Parent_Homes"
                                          )
                              )),
                              mainPanel(plotlyOutput("school_chart"))
                            ),
                   #Tab contains a map that overlays Seattle data and 911 Call Incidents. 
                   #Data can be manipulated with widgets on the side.
                   tabPanel("Comparison",
                            titlePanel("911 Call and Seattle School Comparison"),
                            sidebarPanel(helpText("Select specific type of incident."),
                                         selectInput("comp_call_type", label = "Select Call Type",
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
                                         helpText("View percentages for selected option. Radius corresponds to percentage of selected variable."),
                            selectInput("comp_school_var", label = "Percentage Level",
                                        choices = list("Free Lunches" = "Percent_Free_Lunch",
                                                       "Limited English" = "Percent_Limited_English",
                                                       "Single Parents" = "Percent_One_Parent_Homes"),
                                        selected = "free"
                                        )),
                   mainPanel(leafletOutput("comparemap", height = 800, width = 900))
                   ),
                   tabPanel("Conclusion",
                            includeMarkdown("conclusion.Rmd"))
                            )
)
