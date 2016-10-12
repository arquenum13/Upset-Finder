#https://github.com/juba/scatterD3_shiny_app
library(shiny)
library(scatterD3)

fluidPage(
  
  tags$head(tags$link(rel = "stylesheet",
                      type = "text/css", href = "styles.css")),
  h1("Statistics Explorer"),
  h4("Explore your conference or your favorite team to see which statistic to follow for upcoming matches. The below graphic plots games statistics
     against the probability to cause an upset.", align="center"),
  sidebarLayout(
    sidebarPanel(
      selectInput("conf_x2", "Conferences :",
                  choices = sort(conferences)),
      selectInput("team_x1", "Teams :",
                  choices = sort(teams),
                  selected = "All"),
      selectInput("features_x3", "Statistics :",
                  choices = names(all_Data[c(4:17,21,26)]),
                  selected = "ORPG"),
      selectInput("class", "Odds :",
                  choices = c("Underdog","Favorite"),
                  selected = "Underdog"),
      #checkboxInput("scatterD3_ellipses", "Confidence ellipses", value = FALSE),
      #sliderInput("scatterD3_labsize", "Labels size :",
      #            min = 5, max = 25, value = 11),
      sliderInput("scatterD3_opacity", "Points opacity :", min = 0, max = 1, value = 1, step = 0.05),
      #checkboxInput("scatterD3_transitions", "Use transitions", value = TRUE),
      tags$p(actionButton("scatterD3-reset-zoom", HTML("<span class='glyphicon glyphicon-search' aria-hidden='true'></span> Reset Zoom"))),
             #actionButton("scatterD3-lasso-toggle", HTML("<span class='glyphicon glyphicon-screenshot' aria-hidden='true'></span> Toggle Lasso"), "data-toggle" = "button"),
             #tags$a(id = "scatterD3-svg-export", href = "#",
            #      class = "btn btn-default", HTML("<span class='glyphicon glyphicon-save' aria-hidden='true'></span> Download SVG"))),
      #br(),
      div(strong("Use the below chart to find which statistic is most correlated with the upset probability"), align = "center"), 
          #class="correlation"),#align = "center", style = "font-size: 200px; font-colot; #000000"),
      metricsgraphicsOutput("barchart", width = "100%")
    ),
    mainPanel(
              scatterD3Output("scatterPlot", height = "700px"),
              br(),
              h5(strong("Statistics Acronyms"),style="color:white;"),
              br(),
              div(tableOutput('table2'), align="center", style="color: white;")
              )
  ))
