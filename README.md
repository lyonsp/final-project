###Project Description: 

A Shiny application that explores both Seattle 911 calls and nearby Seattle school data. Plots a density map to show where certain crimes happen most frequently. School data includes percentages of students receiving free lunches, living in single parent homes, and having limited English proficiency. Combines these data sets and generates a map that shows correlations between these sets of data.

Data sources:
* [Seattle 911 Calls](https://data.seattle.gov/Public-Safety/Seattle-Police-Department-911-Incident-Response/3k2p-39jp)
* [Seattle School District](http://www.indiscreetacumen.com/2015/06/seattle-schools-data-graphing-d3/)

Target Audience: The Seattle School District, who could use these correlations to provide support for schools in areas of high crime. The Seattle Police Department, which could use this data to 

###Technical description:
  
Format: The final product should be an HTML page that is easily accessible from any desktop browser.

Data: The data will be read into data frames from the JSON response received from Twitter API.

Data-wrangling: Sort information by mentions, hashtag, location.

Libraries: Knitr, JSON, dplyr, plotly

Challenges:
* Readability of the responses.
* Require OAUTH for each twitter handle to analyze?
* What’s publicly available and what requires OAUTH?
* Running out of time. If the feature set is too ambitious for the time available this may not be realistic. We’ll need to make sure we keep it in scope.


###Project Setup
* create repository
* create issues (5 minimum)
* create slack channel and automatically post in channel anytime someone pushes to repository