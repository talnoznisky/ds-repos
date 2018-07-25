# server.r ###
# input and output for ui.r 
# 

source('source.R')

shinyServer(function(input, output) {
  
  prediction = eventReactive(input$predict,{
    x <- input$text
    n <- as.numeric(input$number)
    prediction = algorithm(x,n)
  })
  output$result = renderTable(prediction(), options = list(pageLength = 10))
  
})
