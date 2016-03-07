library(markdown)
library(plotly)
library(shiny)
library(dplyr)
library(leaflet)

shinyServer(function(input, output) {
  output$mymap2 <- renderLeaflet({
    selected_call <- choose_call_group(input$select)
    leaflet(width = 10, height = 10) %>%
      addTiles() %>% 
      fitBounds(min(call_info$Longitude), min(call_info$Latitude), 
                max(call_info$Longitude), max(call_info$Latitude)) %>% 
      addCircleMarkers(lng = selected_call$Longitude, lat = selected_call$Latitude,
                       radius = .5)
  })
  
  output$bargraph <- renderPlotly({
    select_month(input$selectx)
  })
  
  output$mymap <- renderLeaflet({
    selectedSchoolLevel <- selectSchoolLevel(input$selectlevel)
    leaflet(width = 10, height = 10) %>%
      addTiles() %>%
      fitBounds(min(schoolData$longitude), min(schoolData$latitude),
                max(schoolData$longitude), max(schoolData$latitude)) %>%
      addCircleMarkers(lng = selectedSchoolLevel$longitude, lat = selectedSchoolLevel$latitude,
                       radius = 5)
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
    #schoolDataOrdered <- schoolData %>%  arrange(desc(eval(parse(text = input$poop))))
    #schoolDataLevel <- schoolData %>%  filter(schoolLevel == eval(parse(text = input$school_Level)))
    
    numberOfStudents <- plot_ly(schoolData,
                                x = School.Name,
                                y = n,
                                name = "Number Of Students",
                                type = "bar"
    )
    
    numberOfFreeLunches <- add_trace(
      numberOfStudents,
      x = School.Name,
      y  = eval(parse(text = input$poop)),
      xaxis = (title = "hi"),
      name = "Number of Percentage"
    )
    layout(numberOfFreeLunches, barmode = "stack", xaxis = x, yaxis = y, title = title)
  })
  
  output$comparemap <- renderLeaflet({
    selected_call <- choose_call_group(input$choose)
    selected_sort <- make_choice(input$whichtype)
    leaflet() %>%
      addTiles() %>% 
      fitBounds(min(call_info$Longitude), min(call_info$Latitude), 
                max(call_info$Longitude), max(call_info$Latitude)) %>% 
      addCircleMarkers(lng = selected_call$Longitude, lat = selected_call$Latitude,
                       radius = .5, color = "blue") %>% 
      addCircleMarkers(lng = schoolData$longitude, lat = schoolData$latitude,
                       radius = 3, color = "red", fillOpacity = 3)
  })
})