source('source.R')
#library(shiny)
shinyUI(fluidPage(
  sidebarLayout(
    sidebarPanel(
      textInput("text", label = ('Please enter some text')),
      actionButton("predict", "Get Predictions"),
     br(),
     br(),
      radioButtons(
        "number",
        label="Select number predictions to display",
        choices = c("1","2","3","4","5"),
        selected = "1"
     )
    ),
    mainPanel(
      tableOutput("result")  
    )  
  )
))  
  