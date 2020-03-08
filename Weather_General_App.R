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

