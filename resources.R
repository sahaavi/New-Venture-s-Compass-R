#run the following lines if dash R is not installed on computer

#install.packages("remotes")
#remotes::install_github("plotly/dashR", upgrade = "always", force = TRUE
# install_github('facultyai/dash-bootstrap-components@r-release')
  
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(devtools)
library(tidyr)

app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

app$layout(
  dbcContainer(
    # filters row
    dbcRow(
      list(
        # side filter column
        dbcCol(
          list(
            htmlH1('Filters'),
            htmlDiv(
              list(
                htmlLabel('Time to Start (days)'),
                dccSlider(
                  id='home_tts',
                  min=0,
                  max=100
                )
              )
              
            )
          )
        ),
        dbcCol(
          list(
            htmlLabel('Right'),
            dccDropdown(
              options = list(list(label = "New York City", value = "NYC"),
                             list(label = "San Francisco", value = "SF")),
              value = 'SF'
            )
          )
        )
      )
    ), style = list('max-width' = '85%')  # Change left/right whitespace for the container
  )
)

app$run_server(debug = T)


