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

shinyUI(fluidPage(

  # Application title
title="US Telecom Stocks",
  
  # Application title
titlePanel("US Telecom Stocks"),
p("This app is designed to provide some information about the US telecom industry.
  The first plot visualizes the stock performance of the top four brands. Just input the number of days you wish to view.
  The second component calculates your stock holdings in this industry. Simply input the number of stocks per brand
  and hit calculate. The output is the sum of your holdings based on the last available closing prices."),

br(),  
  # Print plot

  sidebarLayout(
    sidebarPanel(
      radioButtons(
        "from",
        label="Select number of days for historical period",
        choices = c("10","30","60","90","120"),
        selected = "30"
      )),          
    mainPanel(
      plotlyOutput("plot")
    )
),


  
  
  # Layout inputs
hr(),  
fluidRow(
    h4("Enter number of stocks per company to calculate value of holdings as of today"),
    column(width = 2,
           numericInput(
             "a",
             "ATT",
             min = 0,
             0
           ),
           numericInput(
             "s",
             "Sprint",
             min = 0,
             0
           )
    ),
    
    column(width=2,
      numericInput(
        "t",
        "T-Mobile",
        min = 0,
        0
      ),
      numericInput(
        "v",
        "Verizon",
        min = 0,
        0
      )
    ),
    br(),
    column(width = 1,
           actionButton("calc","Calculate")
    ),
    column(width = 3,
           verbatimTextOutput("portfolio")
      )
    )
  )
)
