library(plotly)
library(shiny)
library(tidyr)
library(dplyr)
library(quantmod)

# Define server logic required to draw a line plot
shinyServer(function(input, output) {
   
  output$plot <- renderPlotly({
    
# generate historical data with input from ui.R
    end <- Sys.Date() - 1
    start <- end - as.numeric(input$from)
    getSymbols("TMUS", src="yahoo", from=start, to=end)
    getSymbols("VZ", src="yahoo", from=start, to=end)
    getSymbols("S", src="yahoo", from=start, to=end)
    getSymbols("T", src="yahoo", from=start, to=end)
    
#organize the data
    vz.df <- data.frame(VZ)
    tm.df <- data.frame(TMUS)
    att.df <- data.frame(T) 
    s.df <- data.frame(S)
    
    df <- data.frame(cbind(rownames(tm.df), tm.df[,4], vz.df[,4], att.df[,4], s.df[,4]))
    df[,-1]<- lapply(df[,-1], function(x) as.numeric(as.character(x)))
    
    
    colnames(df) <- c("date","tmobile","verizon","att","sprint")
    stocks <- data.frame(gather(df, company, closingPrice, tmobile:sprint))
    stocks$date <- as.Date(stocks$date)


# draw the line plot with the specified lookback data
    plot_ly(stocks, x=stocks$date, y=stocks$closingPrice, type="scatter", mode="lines", color=stocks$company) %>%
      layout(
             yaxis=list(title="Closing Price"))
  })
  portfolio <- eventReactive(input$calc,{
    paste0("$", sum(
      input$a*df[nrow(df),]$att,
      input$s*df[nrow(df),]$sprint,
      input$t*df[nrow(df),]$tmobile,
      input$v*df[nrow(df),]$verizon      
    ))
  })
  output$portfolio <- renderText({portfolio()})
})

