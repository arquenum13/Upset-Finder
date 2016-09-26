library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)
library(ggplot2)

fluidPage(
  headerPanel("Upsets Between Conferences"),
  
  sidebarLayout(
    
    sidebarPanel(
      sliderInput("year", "Season:", min = 2014, max = 2016, value = 2016, step = 1)),
      
    mainPanel(
      plotOutput("distPlot", width = "100%", height = "800px"))
    #)
  )
)