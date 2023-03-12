# New Venture(s) Compass

## Team Reflection
This document lists feedback and details on the progress for our New Venture(s) Compass app for Milestone 3 in R language.

## Background
The default view provides information on 5 randomly selected countries from the World bank database on different indicators and areas one need to gain knowledge on to start a new business in a country. The app has three tabs which lists different macro and economic indicators that are helpful in starting a new business.
Final goal is that these provide information for user to be able to select the exact country or countries for new ventures and investments that fulfills their interest.

## Development and Implementation - Progress till date 
a. Implemented basic framework in R language across three tabs.
b. Default view with user training information is available.
c. Individual graphs are implemented and all main concepts tested.

### Development and Implementation - The road ahead
a. Implement slider integrations across tabs. Currently only one of the slides (Cost to select) is implemented but is not integrated.
b. Separate histogram for unemployment chart.
c. Legend based interactive selections need to be integrated across charts, Currently implemented in individual charts.
d. Arrange figures with right sizes and provide consistency across charts, Currently this is partially implemented.
e. Fine tune default view for selection across tabs and various input selection(consistency).
f. Add data source on dashboard.
g. Restrict inputs to 10 countries (nice to have).

### Dashboard Advantages
a. There is text embedded above each tab which gives the reader a sense of what they are looking for and why its necessary. 
This story telling approach will guide user interactively and with rationale to select countries.
b. Dashboard has a default view with 5 countries, this makes anyone get quickly familiar with the application.
c. Having built the framework in Python, it really helped to progress in R but not able to get the interactivity between plots work yet.
 
## Dashboard Limitations
a. Data is available only till 2019, new data will be available only in 2024. Till then, history is limited for decision.
b. Some data is not available in the database, graph would report NA.
c. Include more parameters.
d. Logistics Tab graphs not work inside of app lay out.

## Dashboard Open Issues
Please refer to the GitHub issues list and road ahead section.

We hope, one can appreciate the purpose and the functions built and imagined so far of the app.