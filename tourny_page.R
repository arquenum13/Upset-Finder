fluidPage(
  h1("NCAA Tournament Performance"),
  h4("Explore model performance on pervious NCAA Tournaments.", align="center"),
  fluidRow(
    column(2, 
      # checkboxGroupInput("year", label = h3("Season"), 
      #                    choices = list("2016" = 2016, "2015" = 2015, "2014" = 2014,
      #                                   "2013" = 2013, "2012" = 2012, "2011" = 2011,
      #                                   "2010" = 2010),
      #                    selected = 2016)),
     div(radioButtons("season", h3("Season :"),
                 c("2016" = 2016,
                   "2015" = 2015,
                   "2014" = 2014,
                   "2013" = 2013,
                   "2012" = 2012)), style="color: white; font-size: 20px;"),
     br(),
     h5(strong("Bracket Types"),style="color:white;"),
     br(),
     HTML(paste(tags$span(style="color:white; font-size: 20px;", strong("Perfect Bracket")),tags$span(style="color:white; font-size: 20px;", " - A bracket that select all the correct winners.",sep = ""))),
     br(),
     br(),
     HTML(paste(tags$span(style="color:white; font-size: 20px;", strong("Chalk Bracket")),tags$span(style="color:white; font-size: 20px;", " - A bracket that select all the higher seeds as winners."))),
     br(),
     br(),
     HTML(paste(tags$span(style="color:white; font-size: 20px;", strong("FiveThirtyEight Bracket")),tags$span(style="color:white; font-size: 20px;", " - A bracket that reflects the predictions from the FiveThirtyEight model."))),
     br(),
     br(),
     HTML(paste(tags$span(style="color:white; font-size: 20px;", strong("Upset Finder Bracket")),tags$span(style="color:white; font-size: 20px;", " - A bracket that reflects the predictions from the this site's model.")))
     ),
    br(),
    br(),
    br(),
    column(10, 
      #plotOutput("mychart", width = "100%", height = "500px",hover = "plot_hover"),
      #br(),
      uiOutput("ggvis_ui"),
      ggvisOutput("ggvis"),
      p("There are 6 rounds to the NCAA tournament (Play-Ins do not count), for each correct winner picked, a player is awarded 
        points based on what round the winner is picked in. In most cases, the points per round increase as the tournament progresses. 
        The table below presents available scoring by round systems, but for purposes of this site the CBS System is used"),
      br(),
      div(tableOutput('table'), align="center", style="color: white;")
    )
  )
)
