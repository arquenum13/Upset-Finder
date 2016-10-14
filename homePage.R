fluidPage(
  fluidRow( 
    tags$head(
      tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
    
    div(p("NCAA Men's Basketball", class = "check")),
    div(p("Upset Finder", class = "check2")),
    div(id="wrap", img(src='raleigh-pnc-arena-03.png', align = "center", width = "100%", height = "400")),
    div(p("Season Starts November 11, 2016", class = "check")),  
    div(textOutput("currentTime"), class = "check")
  )
)