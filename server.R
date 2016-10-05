library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)
library(ggplot2)
#library(htmltools)
#library(htmlwidgets)
library(metricsgraphics)

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
  
  #output$distPlot <- renderPlot({
  #  heater(input$year)
  #})
  output$barchart <- renderMetricsgraphics({
    corMartix <- cor(data()[,c(25)],data()[,c(4:17,21)])
    dir <- ifelse(corMartix < 0,"Negative","Positive")
    corMartix <- data.frame(Cor = t(corMartix), Features = colnames(corMartix), Direction = dir)
    
    bc <- corMartix %>% mjs_plot(x=Cor, y=Features, title="Feature Correlation") %>%
      mjs_bar() %>%
      mjs_axis_x(xax_format = 'plain')
    return(bc)
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
              #ellipses = input$scatterD3_ellipses,
              point_opacity = input$scatterD3_opacity,
              transitions = T,
              #axes_font_size = "120%",
              #legend_font_size = "14px",
              lasso = TRUE,
              lasso_callback = "function(sel) {alert(sel.data().map(function(d) {return d.lab}).join('\\n'));}")
  })
  
  dataT <- reactive({
    #eval(parse(text=paste('df2$YEAR==',input$year,sep="")))
    #print(paste('df2$YEAR==',input$year,sep=""))
    df2[which(eval(parse(text=paste(paste('df2$YEAR=="Target" | df2$YEAR==',input$year,sep=""),collapse = " | ")))),]
  })
  
  
  output$mychart <- renderPlot({
    #print(dataT())
    ggplot(data=dataT(), aes(x=ROUND, y=PROBABILITY, group=YEAR, colour=as.factor(YEAR))) +
      geom_line(size=2) +
      geom_point(size=3) +
      xlab("") + ylab("Accuracy") + labs(colour = "Season") + theme_grey(base_size = 18) + guides(colour = guide_legend(reverse=T))
  })
  ################################################################################
  #http://stackoverflow.com/questions/33021757/externally-link-to-specific-tabpanel-in-shiny-app
  
  observe({

    query <- parseQueryString(session$clientData$url_search)

    url <- query$tab
    if (is.null(url)) {
      url <- ""
    }
    
    updateTabsetPanel(session, "menu", url)
  })
})
