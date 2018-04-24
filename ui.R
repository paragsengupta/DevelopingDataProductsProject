# library(ggplot2); library(leaflet); library(dplyr); library(tidyr); library(curl); library(lubridate); library(shiny); library(shinythemes); library(leaflet); library(plotly); library(DT)

library(shiny)
library(shinythemes)
library(leaflet)
library(plotly)
library(DT)

fluidPage(theme = shinytheme("flatly"),
          titlePanel("Auto Theft in Toronto"), align="center",
          sidebarLayout(
                  sidebarPanel(align="left",
                               br(),
                               sliderInput("yearrange", 
                                           label = "Map: Select Years range:", 
                                           animate = TRUE,
                                           min = 2000, max = 2017, 
                                           value = c(2010, 2013)
                               ),
                               br(),
                               selectInput(
                                       "selNbr", "Neighborhood: All or Select one?",
                                       c(All = "all", PickOne = "pickone")
                               ),
                               br(),
                               conditionalPanel(
                                       condition = "input.selNbr == 'pickone'",
                                       uiOutput("nbrhood")
                               ),
                               br(),
                               radioButtons(inputId = "chartType",
                                            label = "Charts: Select a data point to plot:", 
                                            choices = c("Premise Type", "Occurrence Day of Week", "Occurrence Month", "Neighborhood"), 
                                            selected = "Premise Type")
                  ),
                  mainPanel(
                          tabsetPanel(
                                  tabPanel("Map", leafletOutput("mymap", width = '100%', height = '400px')                                 
                                  ),
                                  tabPanel("Chart", plotlyOutput("plotOccYear", width="100%", height="500px")),
                                  tabPanel("Data Table", dataTableOutput("table"), style = "font-size: 60%; width: 100%" )
                          )
                  )
          )
)
