#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotly)
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("US Telecom Stocks"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       radioButtons(
         "from",
         "Select number of days for historical period",
         choices = c("10","30","60","90","120")
         
         
       )
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotlyOutput("plot")
    )
  )
))
