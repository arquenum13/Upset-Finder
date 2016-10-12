library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)

fluidPage(
  
  #includeCSS("www/styles.css"),
  tags$head(
  tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
  
  h1("Upset Predictions"),
  h4("Search the table to find a game of interest and check the probability of an upset occuring. An upset is defined as the favorite team 
     losing. The asterisk denotes which team is favored heading into a game.", align = "center"),
  h4("See the About section, for more information on how a team was identified as the favorite.", align = "center"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(inputId = "dates",
                  label = "Date of Game:",
                  choices = unique(as.character(df1$Date)),
                  selected = as.character(current1)),
      
      h6("")
      ),
    
    mainPanel(
      div(DT::dataTableOutput("mydata"), style = "font-size: 110%; width: 100%;background-color: #FFFFFF;")
    )
      )
  )