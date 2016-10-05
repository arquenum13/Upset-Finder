library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)

fluidPage(
  
  #includeCSS("www/styles.css"),
  tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
  
  h1("Upset Locator"),
  h4("Search the table to find match-up of interest and check the probability of an upset occuring"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(inputId = "dates",
                  label = "Select Date of Match:",
                  choices = unique(as.character(df1$Date)),
                  selected = as.character(current1)),
      
      strong("Disclaimer:"),
      h6("This site is a prototype to illustrate the conceptual design of a sport prediction model.  
         The site reflects historical data for the 2015-2016 Men's NCAA Basketball season.  The decision threshold 
         for an upset is 40%.")
      ),
    
    mainPanel(
      div(DT::dataTableOutput("mydata"), style = "font-size: 75%; width: 100%;background-color: #FFFFFF;")
    )
      )
  )