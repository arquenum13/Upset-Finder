library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)
library(metricsgraphics)
library(scatterD3)
library(ggvis)

shinyServer(function(input, output, session) {
  output$mydata <- DT::renderDataTable(datatable(df[df$Date == input$dates,], 
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
    
    if (input$class == "Underdog"){term <- paste("all_Data$ELO_DIFF < 0")
    }else {term <- paste("all_Data$ELO_DIFF > 0")}

    if(input$team_x1 == "All") {
        all_Data[which(all_Data$CONFERENCE==input$conf_x2 & eval(parse(text=term))),]
    } else {
        all_Data[which(all_Data$CONFERENCE==input$conf_x2 & all_Data$TEAM==input$team_x1 & eval(parse(text=term))),]
    }
  })
  
  observeEvent(input$conf_x2, ({

    x <- input$conf_x2
    
    if (is.null(x))
      x <- "All"
    
    updateSelectInput(session, "team_x1",
                      label = "Teams",
                      choices = c("All", sort(unique(as.character(all_Data[which(all_Data$CONFERENCE==x),"TEAM"])))) )
  }))
  
  output$scatterPlot <- renderScatterD3({
    x_var <- data()[,"TEAM"]
    scatterD3(x = data()[,input$features_x3],
              y = data()[,"PROB"],
              xlab = input$features_x3,
              ylab = "Upset Probability",
              col_var = data()$TEAM,
              col_lab = "Teams",
              size_lab = input$scatterD3_labsize,
              symbol_var = data()$RESULT,
              point_opacity = input$scatterD3_opacity,
              transitions = T,
              legend_width = 10,
              lasso = FALSE,
              lasso_callback = "function(sel) {alert(sel.data().map(function(d) {return d.lab}).join('\\n'));}")
  })
  
  dataT <- reactive({
    df2[which(eval(parse(text=paste(paste('df2$YEAR=="Target" | df2$YEAR==',input$year,sep=""),collapse = " | ")))),]
  })
  
  output$table <- renderTable(scoreSys)
  output$table2 <- renderTable(feats, colnames = FALSE)
  
  mdla <- reactive({ mdl[which(mdl$Season == input$season), ] })
  
  mdla %>% 
    ggvis(~Model, ~Score, fill := "blue") %>%
    layer_bars() %>%
    set_options(width = "auto", height = "500px", resizable=FALSE) %>%
    scale_ordinal('x', domain=c('Perfect Bracket','Chalk Bracket','FiveThirtyEight Bracket','Upset Finder Bracket')) %>%
    add_axis("y", title = "Bracket Score", properties = axis_props(labels = list(fontSize = 11))) %>%
    add_axis("x", properties = axis_props(labels = list(fontSize = 20))) %>%
    bind_shiny("ggvis", "ggvis_ui")
  
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
