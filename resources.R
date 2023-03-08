#run the following lines if dash R is not installed on computer

#install.packages("remotes")
#remotes::install_github("plotly/dashR", upgrade = "always", force = TRUE
# install_github('facultyai/dash-bootstrap-components@r-release')
  
library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
library(devtools)
library(ggplot2)
library(tidyr)

bi = read.csv("data/processed/melted_data.csv")
head(bi)

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
            # Time to Start Slider
            htmlDiv(
              list(
                htmlLabel('Time to Start (days)'),
                dccSlider(
                  id='home_tts',
                  min=0,
                  max=100
                )
              )
            ),
            # Cost to Start Slider
            htmlDiv(
              list(
                htmlLabel('Cost to Start (% of income per capita)'),
                dccSlider(
                  id='home_cts',
                  min=0,
                  max=100
                )
              )
            ),
            htmlBr(),
            # Average Interest Rate Slider
            htmlDiv(
              list(
                htmlLabel('Average Interest Rate (%)'),
                dccSlider(
                  id='resources_air',
                  min=0,
                  max=30
                )
              )
            ),
            htmlBr(),
            # Time to Export Slider
            htmlDiv(
              list(
                htmlLabel('Time to Export (hours)'),
                dccSlider(
                  id='logistics_tte',
                  min=0,
                  max=200
                )
              )
            ),
            # Custom Clearance Slider
            htmlDiv(
              list(
                htmlLabel('Custom Clearance'),
                dccSlider(
                  id='logistics_cc',
                  min=0,
                  max=30,
                  value=5
                )
              )
            )
          ),
          style=list(border = "1px solid #d3d3d3")
          ),
        # end of side filter column
        # tabs column
        dbcCol(list(
          htmlH1("New Venture(s) Compass"),
          htmlHr(),
          # top filters row
          dbcRow(list(
            # top filters portion
            dbcCol(
              # dropdown for country
              dccDropdown(
                id = 'countries',
                placeholder='Select countries...',
                value=list('Canada'),
                options = unique(bi$Country.Name),
                multi = TRUE
                )
            ),
            dbcCol(
              # dropdown for years
              dccDropdown(
                id = 'years',
                placeholder= 'Select years',
                value=list('2014'),
                options = unique(bi$year),
                multi = TRUE
              )
            )
            # end of top filters portion
            ))
          ))
        )
      ), style = list('max-width' = '85%')  # Change left/right whitespace for the container
    )
  )

app$run_server(debug = T)