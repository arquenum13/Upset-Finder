#https://github.com/juba/scatterD3_shiny_app
library(shiny)
library(scatterD3)

fluidPage(
  
  tags$head(tags$link(rel = "stylesheet",
                      type = "text/css", href = "styles.css")),
  h1("Statistics Explorer"),
  h4("Explore your conference or your favorite team to see which statistic to follow for upcoming matches. The below graphic plots games statistics
     against the probability to cause an upset."),
  div(class="row",
      div(class="col-md-12",
          div(class="alert alert-warning alert-dismissible",
              HTML('<button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>'),
              HTML("<strong>What you can try here :</strong>
                   <ul>
                   <li>Zoom on the chart with the mousewheel</li>
                   <li>Pan the plot</li>
                   <li>Hover over a dot to display tooltips</li>
                   <li>Hover over the color or symbol legends items</li>
                   <li>Change data settings to see transitions</li>
                   <li>Try the lasso plugin with the toggle button or by using Shift+click</li>
                   </ul>")))),
  sidebarLayout(
    sidebarPanel(
      selectInput("conf_x2", "Conferense :",
                  choices = sort(conferences)),
      selectInput("team_x1", "Team :",
                  choices = sort(teams),
                  selected = "All"),
      selectInput("features_x3", "Features :",
                  choices = names(all_Data[c(4:17,21,26)]),
                  selected = "ORPG"),
      #checkboxInput("scatterD3_ellipses", "Confidence ellipses", value = FALSE),
      #sliderInput("scatterD3_labsize", "Labels size :",
      #            min = 5, max = 25, value = 11),
      sliderInput("scatterD3_opacity", "Points opacity :", min = 0, max = 1, value = 1, step = 0.05),
      #checkboxInput("scatterD3_transitions", "Use transitions", value = TRUE),
      tags$p(actionButton("scatterD3-reset-zoom", HTML("<span class='glyphicon glyphicon-search' aria-hidden='true'></span> Reset Zoom")),
             actionButton("scatterD3-lasso-toggle", HTML("<span class='glyphicon glyphicon-screenshot' aria-hidden='true'></span> Toggle Lasso"), "data-toggle" = "button"),
             tags$a(id = "scatterD3-svg-export", href = "#",
                    class = "btn btn-default", HTML("<span class='glyphicon glyphicon-save' aria-hidden='true'></span> Download SVG"))),
      br(),
      div(h5("Correlation of Statistics"), class="correlation"),#align = "center", style = "font-size: 200px; font-colot; #000000"),
      metricsgraphicsOutput("barchart", width = "100%")
    ),
    mainPanel(scatterD3Output("scatterPlot", height = "700px"))
  ))
