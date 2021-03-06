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
    
    dashboardSidebar(sidebarMenu(id="menu",
      menuItem(text = "Home", tabName = "home"),
      menuItem(text = "About", tabName = "about"),
      menuItem(text = "Predictor", tabName = "forecast"),
      menuItem(text = "Statistics", tabName = "conf"),
      menuItem(text = "Past Tournament", tabName = "ncaa")
      )),
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "home", 
              source("homePage.R", local = TRUE)[1]),
        tabItem(tabName = "about", includeMarkdown("About_Info.Rmd")),
        tabItem(tabName = "conf", class = "body",
                source("Conf_Page.R", local = TRUE)[1]),
        tabItem(tabName = "forecast", class = "body",
              source("pred_tbl.R", local = TRUE)[1]),
        tabItem(tabName = "ncaa",
              source("tourny_page.R", local = TRUE)[1])
      )
    )
  )
)