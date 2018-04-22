# library(shiny); library(shinythemes); library(leaflet); library(plotly); library(DT)

setwd("D:/Professional_n_Knowledge/Data Science John Hopkins/9 Developing Data Products/CourseProject/GTAAutoTheft")
# Identify the separator in .csv
# L <- readLines("GTAAutuTheft20142017.csv", n = 1)
# if (grepl(";", L)) read.csv2("GTAAutuTheft20142017.csv") else read.csv("GTAAutuTheft20142017.csv")
# numfields <- count.fields(textConnection(L), sep = ",")
# numfields
# Get the data and store as a data frame
autoTheft <- read.csv("GTAAutuTheft20142017.csv",  sep=",", na.strings = c("NA", "#DIV/0!", ""))
autoTheftDf <- as.data.frame(autoTheft)

# Create a separate dataframe for Neighbourhood data subset of 10 top crime occurrence areas 
df2 <- as.data.frame(autoTheftDf %>% group_by(Neighbourhood) %>% summarise(n = n()))
df3 <- as.data.frame(df2[order(-df2$n),])
df4 <- as.data.frame(df3[1:10, ])
df4
write.csv(df4, 'NbrHood.csv')
df5 <- as.data.frame(read.csv("NbrHood.csv",  sep=",", na.strings = c("NA", "#DIV/0!", "")))
df5

function(input, output, session) {

        output$nbrhood <- renderUI ({
                selectInput("nbrhood", label = "Map: Choose Neighbourhood", choices = levels(autoTheftDf$Neighbourhood))
        })
        
        output$mymap <- renderLeaflet({
                        
                if(input$selNbr == "pickone"){
                        autoTheftNew <- subset(autoTheftDf, occurrenceyear >= input$yearrange[1] & occurrenceyear <= input$yearrange & Neighbourhood == input$nbrhood)
                }
                else {
                        autoTheftNew <- subset(autoTheftDf, occurrenceyear >= input$yearrange[1] & occurrenceyear <= input$yearrange)
                }
                
                checkins <- data.frame(
                        names = autoTheftNew$Neighbourhood, 
                        lat = autoTheftNew$Lat, 
                        lng = autoTheftNew$Long, 
                        yearocc = autoTheftNew$occurrenceyear,
                        monocc = autoTheftNew$occurrencemonth,
                        dayocc = autoTheftNew$occurrenceday,
                        ptype = autoTheftNew$premisetype
                )
                checkins %>% leaflet() %>% addTiles() %>% 
                        addCircleMarkers(~lng, ~lat, popup = paste0("<b>", "In: ", checkins$names, "<br>", " on ", checkins$monocc, " ", checkins$dayocc, ", ", checkins$yearocc, "<br>", checkins$ptype, " at location ", checkins$lat, ", ", checkins$lng), options = popupOptions(closeButton = FALSE))
        })
        
        output$plotOccYear <- renderPlotly({
                if(input$chartType == "Premise Type") 
                { new_plot <- plot_ly(autoTheftDf, x = ~premisetype) %>% add_histogram(color=~premisetype)
                new_plot <- layout(new_plot, title = "Auto Theft by Premise Type",showlegend=F)
                new_plot <- layout(new_plot, xaxis = list(tickfont = list(color="red"), title = "Premise Type"))
                }
                
                else if(input$chartType == "Occurrence Day of Week") 
                { new_plot <- plot_ly(autoTheftDf, x = ~occurrencedayofweek) %>% add_histogram(color = ~occurrencedayofweek)
                new_plot <- layout(new_plot, title = "Auto Theft by Occurrence Day of Week", showlegend = F)
                new_plot <- layout(new_plot, xaxis = list(tickfont = list(color="brown"), title = "Occurrence Day of Week"))
                }
                
                else if(input$chartType == "Occurrence Month") 
                { new_plot <- plot_ly(autoTheftDf, x = ~occurrencemonth) %>% add_histogram(color=~occurrencemonth)
                new_plot <- layout(new_plot, title = "Auto Theft by Occurrence Month", showlegend = F)
                new_plot <- layout(new_plot, xaxis = list(tickfont = list(color="blue"), title = "Occurrence Month"))
                }
                
                else if(input$chartType == "Neighborhood")
                { new_plot <- plot_ly(df5, x = ~Neighbourhood, y=~n, type = "bar", color=~Neighbourhood, text=~n, textposition = "auto")
                new_plot <- layout(new_plot, title = "Auto Theft by Top 10 Neighborhoods", showlegend = F)
                new_plot <- layout(new_plot, xaxis = list(tickfont = list(color="blue")))
                }
        })
        
        output$table <- renderDataTable({
                autoTheftDf
        }, options = list(lengthMenu = c(8,20,50,100), pageLength = 8))        
}
