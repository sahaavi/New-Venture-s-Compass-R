#run the following lines if dash R is not installed on computer

#install.packages("remotes")
#remotes::install_github("plotly/dashR", upgrade = "always", force = TRUE)
# install_github('facultyai/dash-bootstrap-components@r-release')

library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashBootstrapComponents)
#library(devtools)
library(ggplot2)
library(plotly)
library(tidyr)
library(stringr)
library(dplyr)



app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

bi <- read.csv("data/processed/melted_data.csv")
#bi$year <- as.character(bi$year)

#constructing multilist for drop down (year selection) options with label and value
#the years variable is set to the 'options' argument in dccDropdown()
years <- lapply(
  unique(bi$year),
  function(available_indicator) {
    list(label = available_indicator,
         value = available_indicator)
  }
)


#constructing multilist for drop down (country selection) options with label and value
#the countries variable is set to the 'options' argument in dccDropdown()
countries <- lapply(
  unique(bi$Country.Name),
  function(available_indicator) {
    list(label = available_indicator,
         value = available_indicator)
  }
)

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
            htmlH4('Filters & Controls'),
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
                  max=500,
                  value = list(0, 500),
                  marks = list(
                    "0" = "0",
                    "100" = "100",
                    "200" = "200",
                    "300" = "300",
                    "400" = "400",
                    "500" = "500"
                  ),
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
                  max=250,
                  value = list(0, 250),
                  marks = list(
                    "0" = "0",
                    "60" = "60",
                    "120" = "120",
                    "180" = "180",
                    "250" = "250"
                  ),
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
                  value = list(0, 30),
                  marks = list(
                    "0" = "0",
                    "6" = "6",
                    "12" = "12",
                    "18" = "18",
                    "24" = "24",
                    "30" = "30"
                  ),
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
                  value = list(0, 200),
                  marks = list(
                    "0" = "0",
                    "40" = "40",
                    "80" = "80",
                    "120" = "120",
                    "160" = "160",
                    "200" = "200"
                  ),
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
                  value = list(0, 200),
                  marks = list(
                    "0" = "0",
                    "40" = "40",
                    "80" = "80",
                    "120" = "120",
                    "160" = "160",
                    "200" = "200"
                  ),
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
                value=list(),
                options = countries,
                multi = TRUE
              )
            ),
            dbcCol(
              # dropdown for years
              dccDropdown(
                id = 'years',
                placeholder= 'Select years...',
                value=list(),
                options = years,
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
                    dccGraph(
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
                    dccGraph(
                      id='hm_line',  
                      style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "350px"
                      )
                    )
                  ))
                ))
              )),
              # end of Home tab
              # Resources Tab
              dbcTab(label = 'Resources', children = list(
                dbcRow(list(
                  htmlH5("Financial Consideration"),
                  htmlP("As the next step, we think about knowledge of different resources available or necessary for the business and their supply and demand. \
                                    First is the finance or credit related information.")
                )),
                dbcRow(list(
                  dbcCol(list(
                    htmlH6("Tracking Interest Rate Spread: Lending Rate Minus Deposit Rate (%)"),
                    dccGraph(
                      id='int_line',
                      style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "250px"
                      )
                    )
                  ))  
                )),
                dbcRow(list(
                  htmlH5("Non-Financial Consideration"),
                  htmlP("Other type of resources available or necessary for the business is labor related. Information regarding them is provided below.")
                )),
                dbcRow(list(
                  dbcCol(list(
                    htmlH6("Unemployment Rates between Labor Force with Basic, Intermediate, and Advanced Education"),
                    dccGraph(
                      id='ur_bar',
                      style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "350px"
                      )
                    )
                  )),
                  dbcCol(list(
                    htmlH6("National Estimate of Total Labour Force Participation Rate for Ages 15-24"),
                    dccGraph(
                      id='pr_bar',
                      style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "350px"
                      )
                    )
                  ))
                ),className="g-0")
                
              )),
              # end of Resources tab
              # Logistics Tab
              dbcTab(label = "Logistics", children = list(
                dbcRow(list(
                  htmlH5("Imports and Exports"),
                  htmlP("Logistics of how easy and quick it is to import and export and clear customs? Information regarding them is provided below \
                                    which marks the final items to consider.")
                )),
                # 1st row for bar and radar chart
                dbcRow(list(
                  # multi-bar chart
                  dbcCol(list(
                    htmlH5("Average time to clear Exports through customs (days)"),
                    dccGraph(
                      id='cc_bar'
                    )
                  )),
                  # radar chart
                  dbcCol(list(
                    htmlH5("Logistics Performance Index"),
                    dccGraph(id="lpi_radar", figure={})
                  ))
                )),
                # end of 1st row for bar and radar chart
                # 2nd row for horizontal stacked bar
                dbcRow(list(
                  htmlH5("Time to Export (hours)"),
                  dccGraph(
                    id='tte_sb',
                    style = list(
                      borderWidth = "0",
                      width = "100%",
                      height = "400px"
                    )
                  )
                )),
                # 3rd row for horizontal stacked bar
                dbcRow(list(
                  htmlH5("Time to Import (hours)"),
                  dccGraph(
                    id='tti_sb',
                    style = list(
                      borderWidth = "0",
                      width = "100%",
                      height = "200px"
                    )
                  )
                ))
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
# --HOME CALLBACK--

# --RESOURCES CALLBACK--

# --LOGISTICS CALLBACK--
# callback for logistics cc_bar
app$callback(
  output(id = "cc_bar", property = "figure"),
  list(
    input(id = "countries", property = "value"),
    input(id = "years", property = "value"),
    input(id = "logistics_cc", property = "value")
  ),
  function(years, countries, logistics_cc) {
    if (is.null(countries)) {
      countries <- c('Afghanistan', 'Albania', 'Algeria', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan')
    }
    
    if (is.null(years)) {
      years <- '2014'
    }
    
    if (is.null(logistics_cc)) {
      logistics_cc <- 30
    }
    # fig <- plot_ly(
    #         data = bi %>%
    #           group_by(year) %>%
    #           filter(Series.Name == "Average time to clear exports through customs (days)",
    #                 Country.Name %in% countries,
    #                 year %in% years,
    #                 value < logistics_cc
    #           ),
    #         x = ~year,
    #         y = ~value,
    #         color = ~Country.Name,
    #         type = "bar"
    #       )
    # fig
    
    # p <- bi %>%
    #   filter(Series.Name == "Average time to clear exports through customs (days)",
    #          Country.Name %in% countries,
    #          year %in% years,
    #          value < logistics_cc
    #   ) %>%
    #   ggplot() +
    #   
    #   aes(x = Country.Name, y = value, color = Country.Name) +
    #   geom_col() +
    #   facet_wrap(~year) +
    #   labs(x=NULL, y="Days") +
    #   geom_text(aes(label=value), position=position_stack(vjust=0.5)) +
    #   geom_label(aes(label=Country.Name), position=position_stack(vjust=-0.5)) +
    #   theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    #   ggtitle(NULL) +
    #   labs(tooltip = c("Country Name", "year", "value"))
    
    p <- bi %>%
      filter(Series.Name == "Average time to clear exports through customs (days)",
             Country.Name %in% countries,
             year %in% years,
             value < logistics_cc
      ) %>%
      ggplot() +
      aes(x = year, y = value, fill = Country.Name) +
      geom_bar(stat = "identity", position = "dodge") +
      ggthemes::scale_color_tableau()
    
    ggplotly(p)
  }
)


# callback for logistics lpi_radar
app$callback(
  output(id="lpi_radar", property="figure"),
  list(
    input(id="countries", property="value"),
    input(id="years", property="value")
  ),
  function(countries, years) {
    max <- max(bi[bi$Series.Name == "Logistics performance index: Overall (1=low to 5=high)", "value"], na.rm = TRUE)
    
    min <- min(bi[bi$Series.Name == "Logistics performance index: Overall (1=low to 5=high)", "value"], na.rm = TRUE)
    
    if (is.null(countries)) {
      countries <- c('Afghanistan', 'Albania', 'Algeria', 'Angola', 'Antigua and Barbuda', 'Argentina', 'Armenia', 'Australia', 'Austria', 'Azerbaijan')
    }
    
    if (is.null(years)) {
      years <- '2014'
    }
    
    # radar chart
    fig <- plot_ly(
      type = 'scatterpolar',
      fill = 'toself'
    ) 
    # adding traces
    for (i in countries) {
      
      add_trace(
        r <- bi[bi$Series.Name == "Logistics performance index: Overall (1=low to 5=high)" &
                  bi$Country.Name == i &
                  bi$year %in% years, "value"],
        theta=years,
        name=i
      )
    }
    
    fig <- fig %>%
      layout(
        polar = list(
          radialaxis = list(
            visible = T,
            range = c(min, max)
          )
        )
      )
    fig
  }
)

# callback for logistics tte_sb
app$callback(
  output(id="tte_sb", property="figure"),
  list(input(id="countries", property="value"),
       input(id="years", property="value"),
       input(id="logistics_tte", property="value")),
  
  function(countries, years, hours) {
    filtered_export <- bi %>% 
      filter(Country.Name %in% countries,
             year %in% years,
             Series.Name %in% c('Time to export, border compliance (hours)', 'Time to export, documentary compliance (hours)'),
             value >= hours[1],
             value <= hours[2])
    
    chart <- filtered_export %>%
      ggplot(aes(y = year, x = value, fill = Country.Name)) +
      geom_bar(stat = 'identity', orientation = 'horizontal') +
      facet_grid(Series.Name ~ ., labeller = labeller(Series.Name = label_both(angle = 0))) +
      labs(y = NULL, x = 'Days') +
      geom_text(aes(label = value), hjust = -0.1) +
      theme(legend.position = 'bottom') +
      ggtitle('Time to Export')
    
    ggplotly(chart)
  }
)


# callback for logistics tti_sb
app$callback(
  output(id="tti_sb", property="figure"),
  list(input(id="countries", property="value"),
       input(id="years", property="value"),
       input(id="logistics_tti", property="value")),
  
  function(countries, years, hours) {
    filtered_export <- bi %>% 
      filter(Country.Name %in% countries,
             year %in% years,
             Series.Name %in% c('Time to import, border compliance (hours)', 'Time to import, documentary compliance (hours)'),
             value >= hours[1],
             value <= hours[2])
    
    chart <- filtered_export %>%
      ggplot(aes(y = year, x = value, fill = Country.Name)) +
      geom_bar(stat = 'identity', orientation = 'horizontal') +
      facet_grid(Series.Name ~ ., labeller = labeller(Series.Name = label_both(angle = 0))) +
      labs(y = NULL, x = 'Days') +
      geom_text(aes(label = value), hjust = -0.1) +
      theme(legend.position = 'bottom') +
      ggtitle('Time to Import')
    
    ggplotly(chart)
  }
)



app$run_server(debug = F)

# host = '0.0.0.0'