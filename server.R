library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)
library(ggplot2)

shinyServer(function(input, output, session) {
  output$mydata <- DT::renderDataTable(datatable(df[df$Date == input$dates, -c(1)], 
        options = list(searching = TRUE,pageLength = 25, initComplete = JS("
          function(settings, json) {
            $(this.api().table().header()).css({
              'background-color': '#C0C0C0',
              'color': '#000000'
            });

          }")
       ))
  )
  output$currentTime <- renderText({
    invalidateLater(1000, session)
    paste(round(difftime(start, Sys.time(), units='days')), 'days')
  })
  
  output$myImage <- renderImage({
    filename <- normalizePath(file.path('raleigh-pnc-arena-02.png'))
    
    list(src = filename,
         alt = paste("Image number", input$n))}, deleteFile = FALSE)
  
  output$distPlot <- renderPlot({
    heater(input$year)
  })
  
})
