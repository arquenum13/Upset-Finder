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
  
  data <- reactive({

    if(input$team_x1 == "All") {
    #all_Data[which(all_Data$Conference.y==input$conf_x2 & all_Data$Team==input$team_x1),]
        all_Data[which(all_Data$CONFERENCE==input$conf_x2),]
    } else {
    #all_Data[which(all_Data$Conference.y==input$conf_x2),]
        all_Data[which(all_Data$CONFERENCE==input$conf_x2 & all_Data$TEAM==input$team_x1),]
    }
  })
  
  observeEvent(input$conf_x2, ({

    x <- input$conf_x2
    
    if (is.null(x))
      x <- "All"
    
    updateSelectInput(session, "team_x1",
                      label = "Select Team",
                      choices = c("All", sort(unique(as.character(all_Data[which(all_Data$CONFERENCE==x),"TEAM"])))) )
  }))
  
  output$scatterPlot <- renderScatterD3({
    x_var <- data()[,"TEAM"]
    scatterD3(x = data()[,input$features_x3],
              y = data()[,"PROB"],
              xlab = input$features_x3,
              ylab = "Probability",
              col_var = x_var,
              col_lab = "Team",
              size_lab = input$scatterD3_labsize,
              ellipses = input$scatterD3_ellipses,
              point_opacity = input$scatterD3_opacity,
              transitions = input$scatterD3_transitions,
              #axes_font_size = "120%",
              #legend_font_size = "14px",
              lasso = TRUE,
              lasso_callback = "function(sel) {alert(sel.data().map(function(d) {return d.lab}).join('\\n'));}")
  })
  
  dataT <- reactive({
    df2[which(df2$YEAR==input$year),]
  })
  
  output$mychart <- renderPlot({
    
    ggplot(data=dataT(), aes(x=ROUND., y=PROBABILITY, group=1)) +
      geom_line(size=2,colour="blue") +
      geom_point(size=3, colour="white") +
      expand_limits(y=c(0,1)) +
      xlab("") + ylab("Accuracy")
  })
  
})
