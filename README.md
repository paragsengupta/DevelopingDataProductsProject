# DevelopingDataProductsProject
Shiny Application and Reproducible Pitch - Auto Theft in Toronto

  Author: Parag Sengupta
  
  Date: April 23, 2018

## Introduction:

Auto theft or stealing of somebody else’s vehicle is a crime of a global nature. All mega cities across the world face this problem. Toronto in the province of Ontario in Canada is no exception to it.

In the 4 years spanning January 2014 to December 2017, there were as many as 13,435 auto thefts reported to Toronto Police Service.

This project on Developing Data Products as part of the Coursera Data Science Specialization covers this data.

- The app developed for the first part of the assignment demo is available on shinyapp.io at:
https://paragsengupta.shinyapps.io/gtaautotheft/ 
- The source codes for the Shiny ui.R and server.R files are available on the GitHub repo:
https://github.com/paragsengupta/DevelopingDataProductsProject
- Presentation & Functionality:
http://rpubs.com/Laughing_Lamp/Shiny-Application-and-Reproducible-Pitch

## User Guide on Application:

The core is a Shiny application. To start the application, please click on the following link:
https://paragsengupta.shinyapps.io/gtaautotheft/ 

Through the application, the user can view the crime reported data on an interactive map, view charts which show the trend of historical data as well as a filterable dump of the complete data for the reported period.

The application opens an interactive page with various options available in the top row Menu (Map, Charts, Data Table) to see the information about reported crimes, along with some choices to filter the visuals. The default landing page is the Interactive Map with years 2000 to 2009 displayed.

### Menu Option: Map
This opens up an interactive map of the Greater Toronto Area. The user can use the ‘slider’ on the left panel to choose the range of years to view the data on the interactive map. The data on the map will change based on the start and end years as chosen on the slider. Within the map, the user can zoom in or zoom out with the ‘+ / -‘ buttons respectively. 

To see details of the reported crime, the user can click any blue circle on the map. It will show the name of the area with the hood ID as used by the Toronto Police Service, the actual date the theft was reported, the premise type of the theft and the geographical coordinates of the location.

### Menu Option: Chart
The next option is the Chart which shows three different types of charts. The user can make the choice using the radio buttons on the left side panel. Based on the user choice, the appropriate histogram is displayed. On hovering the mouse over the histogram bars, the auto theft crime count can be seen displayed.

### Menu Option: Data Table
This option provides a complete dump of 13,480 auto theft information in Greater Toronto Area. The user can search for specific data points using the Search dialog box. Every column representing a data variable can be sorted in ascending or descending order by clicking on the small arrows next to the variable name.

#### ----------------------------------------------------------------------------------------------------
