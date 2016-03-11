# Read in data
library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

# This server uses input values to select particular information to be displayed on an output.
shinyServer(function(input, output) {
  # Renders Leaflet map of 911 call incidents
  output$incident_map <- renderLeaflet({
    selected_call <- choose_call_group(input$select_call_type) %>% # Selects 911 call type based on user's input
                      group_by(Event.Clearance.Group) %>% # groups dataframe by Event.Clearance.Group
                      filter(grepl(input$select_month, Event.Clearance.Date)) # filters data frame to selected month
    # Creates Leaflet Map
    leaflet() %>%
      addTiles() %>% 
      # Fits bounds to min and max latitude and longitude given by 2012 911 call data
      fitBounds(min(only_2012$Longitude), min(only_2012$Latitude), 
                max(only_2012$Longitude), max(only_2012$Latitude)) %>% 
      # Creates a marker for each incident of selected call type
      addCircleMarkers(lng = selected_call$Longitude, lat = selected_call$Latitude,
                       color = "blue",
                       radius = 3,
                       stroke = FALSE)
  })
  
  # Renders Plotly chart for 911 calls given a selected month
  output$incident_chart <- renderPlotly({
    # Selects data to show based on user's input.
    select_month(input$select_month)
  })
  
  # Renders Leaflet map of Seattle schools.
  output$school_map <- renderLeaflet({
    # Uses function to select school level(elem, middle, high) based on user's choice.
    selectedSchoolLevel <- selectSchoolLevel(input$school_level)
    # Creates Leaflet map.
    leaflet() %>%
      addTiles() %>%
      # Fits bounds to min and max latitude and longitude given by Seattle school data.
      fitBounds(min(schoolData$longitude), min(schoolData$latitude),
                max(schoolData$longitude), max(schoolData$latitude)) %>%
      # Creates a marker for each school with radius based on percentage of given input.
      addCircleMarkers(lng = selectedSchoolLevel$longitude, lat = selectedSchoolLevel$latitude,
                       color = "red",
                       fillOpacity = .6,
                       radius = (eval(parse(text = input$school_var), selectedSchoolLevel) / selectedSchoolLevel$Total_Students) * 15,
                       stroke = FALSE,
                       # When marker is clicked, shows school name.
                       popup = schoolData$School_Name)
  })
  
  # Renders Plotly chart that compares the number of students with/without given variable (free lunch, lim. english, single parent home)
  output$school_chart <- renderPlotly ({
    # Uses function to select school level given user's choice.
    specificSchoolLevel <- selectSchoolLevel(input$school_level)
    # Creates Plotly bargraph about school data.
    numberOfStudents <- plot_ly(specificSchoolLevel,
                                x = School_Name,
                                y = Total_Students,
                                name = "Number Of Students",
                                type = "bar",
                                marker = list(color = toRGB("cadetblue3"))
    )
    # Adds trace with information about students with given variable.
    numberOfFreeLunches <- add_trace(
      numberOfStudents,
      x = School_Name,
      y  = eval(parse(text = input$school_var)),
      name = paste0("Number of ", input$school_var),
      marker = list(color = toRGB("red"))
    ) %>%
    # Adds titles to graph and x and y axes.
    layout(barmode = "stack", 
           xaxis = list(title = "School Names"), yaxis = list(title = "Number of Students"), 
           title = paste0("Number of Students With and Without ", input$school_var),
           margin = list("b" = 150))
  })
  
  # Renders Leaflet map comparing 911 and school data.
  output$comparemap <- renderLeaflet({
    # Uses choose_call_group function to use user's input related to call type.
    selected_call <- choose_call_group(input$comp_call_type)
    # Uses make_choice function to use user's input related to school variable.
    selected_sort <- make_choice(input$comp_school_var)
    # Evaluates text and makes decimal into percent string.
    percentage <- eval(parse(text = input$comp_school_var), selected_sort)
    # Creates leaflet map.
    leaflet() %>%
      addTiles() %>% 
      # Fits bounds to min and max latitude and longitude given by 911 call data.
      fitBounds(min(only_2012$Longitude), min(only_2012$Latitude), 
                max(only_2012$Longitude), max(only_2012$Latitude)) %>% 
      # Creates a marker for each incident of selected call type
      addCircleMarkers(lng = selected_call$Longitude, lat = selected_call$Latitude,
                       radius = 3, 
                       color = "blue", 
                       stroke = FALSE, 
                       fillOpacity = .5,
                       selected_call) %>% 
      # Creates a marker for each school with radius based on percentage of given input.
      addCircleMarkers(lng = schoolData$longitude, lat = schoolData$latitude,
                       radius = percentage * 12, 
                       color = "red", 
                       stroke = FALSE,
                       fillOpacity = .8,
                       # When marker is clicked, shows school name and given percentage.
                       popup = paste0(schoolData$School_Name, " ", round(percentage * 100, 3), "%")) %>% 
      # Creates a legend to match marker color to type of marker.
      addLegend(position = 'topright', colors = "blue", labels = "911 Calls", opacity = 0.8) %>% 
      addLegend(position = 'topright', colors = "red", labels = "Schools", opacity = 0.8)
  })
})