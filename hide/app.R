#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
# http://dmcritchie.mvps.org/excel/colors.htm
# https://www.google.com/fonts
# https://blog.rstudio.org/2015/06/24/dt-an-r-interface-to-the-datatables-library/
# http://shiny.rstudio.com/tutorial/lesson2/

library(shiny)
library(markdown)
library(magrittr)
library(DT)

df <- read.csv("2015-2016_Schedule.csv", header = TRUE)
df$Date <- as.Date(gsub("/","-",as.character(df$Date)), "%m-%d-%Y")
current1 <- as.Date("2015-11-20") #sys.date()
week <- current1 + 7
df1 <- df[df$Date <= week,]
# current2 <- current1 + 1
# current3 <- current1 + 2
#disDate <- as.character(current1)

# Define UI for application that draws a histogram
ui <- shinyUI(fluidPage(

  includeCSS("styles.css"),
  
  headerPanel("NCAAB UPSET ALERTS!!!"),

   sidebarLayout(
     
     sidebarPanel(
      # tags$head(
      #   tags$style(type="text/css", "select { max-width: 140px; }"),
      #   tags$style(type="text/css", ".span4 { max-width: 190px; }"),
      #   tags$style(type="text/css", ".well { max-width: 180px; }")
      # ),
       # tags$head(
       #   tags$style(HTML('#b1{background-color:orange;color:blue;font-size: 20px;}')),
       #   tags$style(HTML('#b2{background-color:orange;color:blue;font-size: 20px;}')),
       #   tags$style(HTML('#b3{background-color:orange;color:blue;font-size: 20px;}'))
       # ),
       
       selectInput(inputId = "dates",
                   label = "Select Date of Match:",
                   choices = unique(as.character(df1$Date)),
                   selected = as.character(current1)),
       
       strong("Disclaimer:"),
       h5("This site is a prototype to illustrate the conceptual design of a sport prediction model.  
          The site reflects historical data for the 2015-2016 Men's NCAA Basketball season.  The decision threshold 
          for an upset is 40%.")
       
      # h3("Upcoming Schedule", align = "center"),
      # actionButton(inputId = "b1", label = format(current1,"%b %d, %Y"), icon = NULL, width = '100%'),
      # actionButton(inputId = "b2", label = format(current2,"%b %d, %Y"), icon = NULL, width = '100%'),
      # actionButton(inputId = "b3", label = format(current3,"%b %d, %Y"), icon = NULL, width = '100%')
    ),
 
    mainPanel(
      #div(h4(paste("Schedule for", format(current1,"%b %d, %Y")), align = "center"), style = "color: #FFFFFF;"),
      div(dataTableOutput("mydata"), style = "font-size: 75%; width: 100%;background-color: #FFFFFF;")
    )
  )
))

# Define server logic required to draw a histogram
server <- shinyServer(function(input, output) {
  #paging = FALSE
  
  output$mydata <- renderDataTable(datatable(df[df$Date == input$dates,-c(1)], 
          options = list(searching = TRUE,pageLength = 20, initComplete = JS("
          function(settings, json) {
            $(this.api().table().header()).css({
              'background-color': '#C0C0C0',
              'color': '#000080'
            });

          }")
    ))
  )
})

# Run the application 
shinyApp(ui = ui, server = server)

