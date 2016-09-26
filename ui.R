library(shiny)
library(markdown)
library(magrittr)
library(DT)
library(shinydashboard)

shinyUI(
  dashboardPage(
    skin = "black",
    dashboardHeader(
      title = "Search Contents"),
    
    dashboardSidebar(sidebarMenu(
      menuItem(text = "Home", tabName = "home"),
      menuItem(text = "Forecast", tabName = "forecast"),
      menuItem(text = "Conferences",
        menuSubItem(text = "ACC", tabName = "acc"),
        menuSubItem(text = "SEC", tabName = "sec"),
        menuSubItem(text = "BIG 12", tabName = "big12"),
        menuSubItem(text = "PAC 12", tabName = "pac12"),
        menuSubItem(text = "BIG 10", tabName = "big10")), 
      menuItem(text = "NCAA Tournament",
               menuSubItem(text = "2012", tabName = "y2012"),
               menuSubItem(text = "2013", tabName = "y2013"),
               menuSubItem(text = "2014", tabName = "y2014"),
               menuSubItem(text = "2015", tabName = "y2015"),
               menuSubItem(text = "2016", tabName = "y2016")),
      menuItem(text = "About", tabName = "about")
      )),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "home", 
              source("homePage.R", local = TRUE)[1]),
      tabItem(tabName = "forecast", class = "body",
              source("pred_tbl.R", local = TRUE)[1]),
      tabItem(tabName = "about", includeMarkdown("About_Info.Rmd"))
      )
    )
  )
)