library(shiny)
library(ggplot2)
library(dplyr)
library(plotly)
library(lubridate)
library(tidyr)
library(rsconnect)
library(shinythemes)

source("ui.r")
source("server.r")

# Runs the app
shinyApp(ui, server)
