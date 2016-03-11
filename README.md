## Shiny Application

The completed Shiny application is accessible [here](https://kandrewc.shinyapps.io/SeattleSchoolsWith911incidents/)

## Project Description: 

A Shiny application that explores both Seattle 911 calls and nearby Seattle school data. Plots a density map to show where certain crimes happen most frequently. School data includes percentages of students receiving free lunches, living in single parent homes, and having limited English proficiency. Combines these data sets and generates a map that shows correlations between these sets of data.

Target Audience: The Seattle School District, who could use these correlations to provide support for schools in areas of high crime. The Seattle Police Department, which could use this data to predict where to focus resources and attention.

Data sources:

- [Seattle 911 Calls](https://data.seattle.gov/Public-Safety/Seattle-Police-Department-911-Incident-Response/3k2p-39jp)

- [Seattle School District](http://www.indiscreetacumen.com/2015/06/seattle-schools-data-graphing-d3/)

## Technical description:

Format: The final product should be an HTML page that is easily accessible from any desktop browser.

Data: The data are formatted as .csv files. The Seattle 911 Call file is sorted down to 2012 incidents. Some manual entry required from a .pdf file necessary for Seattle School file.

Libraries: Dplyr, Plotly, Leaflet, Shiny
