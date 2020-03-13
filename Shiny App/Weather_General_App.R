if (!require("tidyverse")) install.packages('tidyverse')
library(tidyverse)
if (!require("skimr")) install.packages('skimr')
library(skimr)
if (!require("naniar")) install.packages('naniar')
library(naniar)
if (!require("shiny")) install.packages('shiny')
library(shiny)
if (!require("shinydashboard")) install.packages('shinydashboard')
library(shinydashboard)

weather <- readr::read_csv("data/weather.csv")

weather %>%
  select(-"X1")

new_factor<- c(1:5,26)
new_numeric<- c(6:25)
weather[,new_factor] <- lapply(weather[,new_factor], as.factor)
weather[,new_numeric] <- lapply(weather[,new_numeric], as.numeric)
lapply(weather, class) #changing classes

weather_temp <- weather %>% 
  select(year, city, avg_temp) %>% 
  group_by(city, year) %>%
  summarize(Average_Temp=mean(avg_temp)) %>% 
  rename(City="city", Year="year")

weather_dewpt <-weather %>% 
  select(year, city, avg_dewpt) %>% 
  group_by(city, year) %>%
  summarize(Average_Dew_Point=mean(avg_dewpt)) %>% 
  select(-c("year"))

weather_humidty <- weather %>% 
  select(year, city, avg_humidity) %>% 
  group_by(city, year) %>%
  summarize(Average_Humidty=mean(avg_humidity)) %>%
  select(-c("year"))

weather_wind <- weather %>% 
  select(year, city, avg_wind) %>% 
  group_by(city, year) %>%
  summarize(Average_Wind=mean(avg_wind)) %>%
  select(-c("year"))

weather_mean <- cbind(weather_temp, weather_dewpt, weather_humidty, weather_wind) #combining yearly averages into one table

weather_cleaner <- weather_mean %>% 
  select(-c(4,6,8)) %>% #deleting repetitive columns
  pivot_longer(Average_Temp:Average_Wind,
               names_to = "Measure",
               values_to = "Value")

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(disable = T),
  dashboardBody(
    fluidRow(
      box(title = "Plot Options", width = 3,
          radioButtons("x", "Select Year", choices = c("2016", "2017"), 
                       selected = "2016"),
          selectInput("y", "Select Measure", choices = c("Average_Temp", "Average_Dew_Point", "Average_Humidty", "Average_Wind"),
                      selected = "Average_Temp"),
      ), # close the first box
      box(width =6,
          plotOutput("plot", width = "800px", height = "600px")
      ) # close the second box
    ) # close the row
  ) # close the dashboard body
) # close the ui

server <- function(input, output, session) {
  
  output$plot <- renderPlot({
    weather_cleaner %>% 
      filter(Year==input$x & Measure == input$y) %>% 
      ggplot(aes(x=City, y=Value, fill=City)) + 
      geom_bar(stat="identity", color="black", alpha=0.6) +
      labs(title = "Weather in Certain Cities from 2016-2017",
           x="City", y=input$y) +
      theme(plot.title = element_text(size = 27, face = "bold", hjust = 0.5),
            axis.text = element_text(size = 15),
            axis.title = element_text(size = 18),
            legend.title = element_text(size = 18),
            legend.text = element_text(size=15))
  })
  
  session$onSessionEnded(stopApp)
  
}

shinyApp(ui, server)