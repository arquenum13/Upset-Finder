fluidPage(
  tags$h2("NCAA Tournament Performance"),
  fluidRow(
      plotOutput("mychart", width = "100%", height = "500px"),
      p(),
      div(sliderInput("year", "Season", 2000, 2016, 2016, step=1,
        animate=animationOptions(interval=1, loop=TRUE), width = "90%"), align = "center")
  )
)
