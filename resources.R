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
  dbcContainer(list(
    htmlH1("New Venture(s) Compass", style = list(
      textAlign = "center"
    )),
    htmlHr(),
    # filters row
    dbcRow(
      list(
        # side filter column
        dbcCol(
          list(
            htmlBr(),
            htmlH1('Filters & Controls'),
            htmlHr(),
            #Home tab sliders
            htmlBr(),
            htmlH5("Home tab", style = list(
              textAlign = "center"
            )),
            htmlBr(),
            # Cost to Start Slider
            htmlDiv(
              list(
                htmlLabel('Cost to Start (% of income per capita)'),
                dccRangeSlider(
                  id='home_cts',
                  min=0,
                  max=100,
                  value = list(0, 500),
                  tooltip = list(
                    placement = 'bottom'
                  )
                )
              )
            ),
            # Time to Start Slider
            htmlDiv(
              list(
                htmlLabel('Time to Start (days)'),
                dccRangeSlider(
                  id='home_tts',
                  min=0,
                  max=100,
                  value = list(0, 250),
                  tooltip = list(
                    placement = 'bottom'
                  )
                )
              )
            ),
            #Resources tab sliders
            htmlBr(),
            htmlH5("Resources tab", style = list(
              textAlign = "center"
            )),
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
            #Logisitics tab sliders
            htmlBr(),
            htmlH5("Logistics tab", style = list(
              textAlign = "center"
            )),
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
            # Time to Import Slider
            htmlDiv(
              list(
                htmlLabel('Time to Import (hours)'),
                dccRangeSlider(
                  id='logistics_tti',
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
          #Header across tabs
          htmlH3("An Interactive Guide to Select Countries for Establishing Your New Business",style = list(
            textAlign = "center"
          )),
          htmlHr(),
          dbcRow(list(
            htmlP('Hi there! Congratulations on thinking about starting a new business! \
                This dashboard is an interactive guide that helps to understand different aspects that are important in starting a business.'),
            htmlP('In default mode, it shows data for 10 countries that are in World Bank datase. \
                We recommend to start browsing through the tabs to get an idea of different aspects. \
                Once finished, you can choose years and countries for your own assessment, Remember, both inputs are mandatory. \
                Sliders are present on the side to further fine tune your selection. \
                ')
          )),
          # top filters row
          dbcRow(list(
            # top filters portion
            dbcCol(
              # dropdown for country
              dccDropdown(
                id = 'countries',
                placeholder='Select countries...',
                #value=list('Canada'),
                options = unique(bi$Country.Name),
                multi = TRUE
                )
            ),
            dbcCol(
              # dropdown for years
              dccDropdown(
                id = 'years',
                placeholder= 'Select years...',
                #value=list('2014'),
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
                dbcRow(htmlH5("Geographic Location")),
                dbcRow(list(
                  dbcCol(list(
                    htmlP('Understanding the geographic location of the country is very important. This helps to know the neighboring countries, ports etc.'), 
                    htmlIframe(
                      id='hm_map',
                      style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "250px"
                      )
                    )
                  ))   
                )),
                dbcRow(list(
                  htmlH5("Cost and Time requirements to start a business"),
                  htmlP("Cost and time factors are very important. Cost tells us how costly interms of a countrie's % of income per capita \
                                    is required to start a business in the country. Time tells us how many days are required in business starting procedures. \
                                    Lower the percentage and days, favorable it is for anyone to start a business.")
                )),
                dbcRow(list(
                  dbcCol(list(
                    htmlIframe(
                      id='hm_line',  style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "350px"
                      )
                    )
                  ))
                ))
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
    ))
  )

# callback for resources int_line

app$run_server(debug = T)