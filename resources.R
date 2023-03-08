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
                dccRangeSlider(
                  id='home_tts',
                  min=0,
                  max=100,
                  tooltip = list(
                    placement = 'bottom'
                  )
                )
              )
            ),
            # Cost to Start Slider
            htmlDiv(
              list(
                htmlLabel('Cost to Start (% of income per capita)'),
                dccRangeSlider(
                  id='home_cts',
                  min=0,
                  max=100,
                  tooltip = list(
                    placement = 'bottom'
                  )
                )
              )
            ),
            htmlBr(),
            # Average Interest Rate Slider
            htmlDiv(
              list(
                htmlLabel('Average Interest Rate (%)'),
                dccRangeSlider(
                  id='resources_air',
                  min=0,
                  max=30,
                  tooltip = list(
                    placement = 'bottom'
                  )
                )
              )
            ),
            htmlBr(),
            # Time to Export Slider
            htmlDiv(
              list(
                htmlLabel('Time to Export (hours)'),
                dccRangeSlider(
                  id='logistics_tte',
                  min=0,
                  max=200,
                  tooltip = list(
                    placement = 'bottom'
                  )
                )
              )
            ),
            # Custom Clearance Slider
            htmlDiv(
              list(
                htmlLabel('Custom Clearance'),
                dccInput(
                  id='logistics_cc',
                  placeholder = 'Value',
                  type = 'number',
                  inputMode = 'numeric',
                  min=0,
                  max=30,
                  value = 5
                )
              )
            )
          ),
          className = "col-md-3",
          style=list(border = "1px solid #d3d3d3", borderRadius = "10px")
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
            
            )),
            # end of top filters row
          htmlBr(),
          # tabs row
          dbcRow(list(
            # tabs
            dbcTabs(id = 'tabs', children = list(
              # Home Tab
              dbcTab(label = 'Home', children = list(
                
              )),
              # Resources Tab
              dbcTab(label = 'Resources', children = list(
                htmlH4("Financial Consideration")
              )),
              # Logistics Tab
              dbcTab(label = "Logistics", children = list(
                
              ))
              
            ))
            # end of tabs
            ))
            # end of tabs row
          ))
            # end of tabs column
        )
      # end of filters row
      )
    )
  )

# callback for resources int_line

app$run_server(debug = T)