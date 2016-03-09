library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

shinyServer(function(input, output) {
  output$mymap2 <- renderLeaflet({
    selected_call <- choose_call_group(input$select)
    leaflet() %>%
      addTiles() %>% 
      fitBounds(min(call_info$Longitude), min(call_info$Latitude), 
                max(call_info$Longitude), max(call_info$Latitude)) %>% 
      addCircleMarkers(lng = selected_call$Longitude, lat = selected_call$Latitude,
                       color = "blue",
                       radius = 3,
                       stroke = FALSE)
  })
  
  output$bargraph <- renderPlotly({
    select_month(input$selectx)
  })
  
  output$mymap <- renderLeaflet({
    selectedSchoolLevel <- selectSchoolLevel(input$selectlevel)
    leaflet() %>%
      addTiles() %>%
      fitBounds(min(schoolData$longitude), min(schoolData$latitude),
                max(schoolData$longitude), max(schoolData$latitude)) %>%
      addCircleMarkers(lng = selectedSchoolLevel$longitude, lat = selectedSchoolLevel$latitude,
                       color = "red",
                       fillOpacity = .6,
                       radius = 5,
                       stroke = FALSE,
                       popup = schoolData$School_Name)
  })
  
  output$schoolDataChart <- renderPlotly ({
    x <- list(
      title = "School Names"
    )
    y <- list(
      title = "Number of Students"
    )
    title <- list(
      title = "Number of Students vs Number of Free Lunches"
    )
    
    numberOfStudents <- plot_ly(schoolData,
                                x = School_Name,
                                y = Total_Students,
                                name = "Number Of Students",
                                type = "bar"
    )
    
    numberOfFreeLunches <- add_trace(
      numberOfStudents,
      x = School_Name,
      y  = eval(parse(text = input$school_var)),
      title = "blah",
      xaxis = (title = "hi"),
      name = "Number of Percentage"
    ) %>%
    layout(barmode = "stack", 
           xaxis = x, yaxis = y, 
           title = "Test",
           margin = list("b" = 150))
  })
  
  output$comparemap <- renderLeaflet({
    selected_call <- choose_call_group(input$choose)
    selected_sort <- make_choice(input$whichtype)
    percentage <- eval(parse(text = input$whichtype), selected_sort)
    leaflet() %>%
      addTiles() %>% 
      fitBounds(min(call_info$Longitude), min(call_info$Latitude), 
                max(call_info$Longitude), max(call_info$Latitude)) %>% 
      addCircleMarkers(lng = selected_call$Longitude, lat = selected_call$Latitude,
                       radius = 3, 
                       color = "blue", 
                       stroke = FALSE, 
                       fillOpacity = .5,
                       selected_call) %>% 
      addCircleMarkers(lng = schoolData$longitude, lat = schoolData$latitude,
                       radius = percentage * 10, 
                       color = "red", 
                       stroke = FALSE,
                       fillOpacity = .8,
                       popup = paste0(schoolData$School_Name, " ", round(percentage * 100, 3), "%"))
  })
})