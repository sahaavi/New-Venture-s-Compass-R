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



app <- Dash$new(external_stylesheets = dbcThemes$BOOTSTRAP)

bi <- read.csv("data/processed/melted_data.csv")
df <- read.csv("data/raw/world_country_and_usa_states_latitude_and_longitude_values.csv")

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
                value=list('Afghanistan','Australia','Canada','Albania','Algeria'),
                options = countries,
                multi = TRUE
              )
            ),
            dbcCol(
              # dropdown for years
              dccDropdown(
                id = 'years',
                placeholder= 'Select years...',
                value=list('2014','2015','2016','2017','2018','2019'),
                options = years,
                multi = TRUE
              ))
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
                    htmlP('TUnderstanding the geographic location of the country is very important. This helps to know the neighboring countries, ports etc.'), 
                    dccGraph(
                      #id='hm_map',
                      id='plot-area'#,
                      #style = list(
                       # borderWidth = "0",
                        #width = "100%",
                        #height = "250px"
                      #)
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
                      #id='bar-plot',
                      style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "350px"
                      )
                    )
                  )),
                  dbcCol(list(
                    dccGraph(
                      id='hm_line2',
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
                      id='cc_bar',
                      style = list(
                        borderWidth = "0",
                        width = "100%",
                        height = "500px"
                      )
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
app$callback(
  output('plot-area', 'figure'),
  list(input(id = 'years', property = 'value'),
       input(id = 'countries', property = 'value')),
  
  function(years, countries) {
#      value <- 'Australia'
      df <- df %>%
        filter(country %in% countries)
      p <- plot_geo(df, locationmode = 'world', sizes = c(5, 250)) %>%
        add_markers(x = ~longitude, y = ~latitude, text = ~country, hoverinfo = 'text')
    
    ggplotly(p, tooltip = 'text') %>% layout(dragmode = 'select')
  }
)


app$callback(
  output(id = 'hm_line', property = 'figure'),
  list(input(id = 'years', property = 'value'),
       input(id = 'countries', property = 'value')),
  
  function(years, countries) {
    
    series_name <- 'Cost of business start-up procedures (% of GNI per capita)'
    p1 <- ggplot(bi %>%
                  filter(Series.Name == series_name, 
                         year %in% years, 
                         Country.Name %in% countries)) +
      aes(x = year, y = value, color = Country.Name, text = Country.Name) +
      geom_point(shape = "circle",stat='identity') +
      geom_line(stat='identity') +
      xlab("Time (year)") +
      ylab ("Cost of business start-up procedures") +
      xlim(2014, 2019) +
      ggthemes::scale_color_tableau()
    
    #p2 <- ggplot(msleep) +
    #  aes(x=vore) +
    #  geom_bar(stat='count')
    # , ggplotly(p2)
    
    ggplotly(p1, tooltip = 'text') %>% layout(dragmode = 'hover')
  }
)

app$callback(
  output('hm_line2', 'figure'),
  list(input(id = 'years', property = 'value'),
       input(id = 'countries', property = 'value')),
  
  function(years, countries) {
    #sel_ctry <- selected_data[[1]] %>% purrr::map_chr('text')
    #print(bi %>% filter(Country.Name %in% countries))
    #print(toString(selected_data))
    #sel_ctry <- list('Afghanistan','Canada')
    #print(sel_ctry)
    series_name <- 'Time required to start a business (days)'
    p <- ggplot(bi %>%
                   filter(Series.Name == series_name, 
                          year %in% years, 
                          Country.Name %in% countries)) +
      aes(x = year, y = value, color = Country.Name,text = Country.Name) +
      geom_point(shape = "circle",stat='identity') +
      geom_line(stat='identity') +
      xlab("Time (year)") +
      ylab ("Time of business start-up procedures") +
      xlim(2014, 2019) +
      ggthemes::scale_color_tableau()

    ggplotly(p, tooltip = 'text') %>% layout(dragmode = 'select')
  }
)

# --RESOURCES CALLBACK--
#Line chart (interest rate)
app$callback(
  output(id = 'int_line', property = 'figure'),
  list(input(id = 'years', property = 'value'),
       input(id = 'countries', property = 'value')),
  
  function(years, countries) {
    
    series_name <- 'Interest rate spread (lending rate minus deposit rate, %)'
    p <- bi %>%
      filter(Series.Name == series_name, 
             year %in% years, 
             Country.Name %in% countries) %>%
      ggplot() +
      aes(x = year, y = value, color = Country.Name) +
      geom_point(shape = "circle") +
      geom_line() +
      xlab("Time (year)") +
      ylab ("Average Interest Rate") +
      xlim(2014, 2019) +
      ggthemes::scale_color_tableau()
    
    ggplotly(p)
  }
)

#Bar chart (unemployment)
app$callback(
  output(id = 'ur_bar', property = 'figure'),
  list(input(id = 'years', property = 'value'),
       input(id = 'countries', property = 'value')),
  
  function(years, countries) {
    
    series_name <- list('Unemployment with basic education (% of total labor force with basic education)', 
                        'Unemployment with intermediate education (% of total labor force with intermediate education)',
                        'Unemployment with advanced education (% of total labor force with advanced education)')
    p <- bi %>%
      filter(Series.Name %in% series_name, 
             year %in% years, 
             Country.Name %in% countries) %>%
      mutate(education_level = str_extract(Series.Name, "Unemployment with (\\w+) education")) %>%
      ggplot() +
      aes(x = Country.Name, y = value, color = education_level) +
      geom_bar() +
      xlab("Country") +
      ylab ("Unemployment Rate") +
      ggthemes::scale_color_tableau()
    
    ggplotly(p)
  }
)

#Bar chart (participation)
app$callback(
  output(id = 'pr_bar', property = 'figure'),
  list(input(id = 'years', property = 'value'),
       input(id = 'countries', property = 'value')),
  
  function(years, countries) {
    
    series_name <- 'Labor force participation rate for ages 15-24, total (%) (national estimate)'
    p <- bi %>%
      filter(Series.Name == series_name, 
             year %in% years, 
             Country.Name %in% countries) %>%
      ggplot() +
      aes(x = value, y = Country.Name, color = Country.Name) +
      geom_bar() +
      xlab("Participation Rate") +
      ylab ("Country") +
      ggthemes::scale_color_tableau()
    
    ggplotly(p)
  }
)

# --LOGISTICS CALLBACK--

app$run_server(host = '0.0.0.0')

# host = '0.0.0.0'