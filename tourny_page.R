fluidPage(
  h1("NCAA Tournament Performance"),
  h4("Explore model performance on pervious NCAA Tournamenst."),
  fluidRow(
    column(2, 
      checkboxGroupInput("year", label = h3("Season"), 
                         choices = list("2016" = 2016, "2015" = 2015, "2014" = 2014,
                                        "2013" = 2013, "2012" = 2012, "2011" = 2011,
                                        "2010" = 2010, "2009" = 2009, "2008" = 2008,
                                        "2007" = 2007, "2006" = 2006, "2005" = 2005,
                                        "2004" = 2004, "2003" = 2003, "2002" = 2002,
                                        "2001" = 2001, "2000" = 2000),
                         selected = 2016)),
    br(),
    br(),
    br(),
    column(10, 
      plotOutput("mychart", width = "100%", height = "500px",hover = "plot_hover")
    )
  )
)
