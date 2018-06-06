library(plotly)
library(tidyr)
library(dplyr)
library(quantmod)

end <- Sys.Date()
start <- end - 90

getSymbols("TMUS", src="yahoo", from=start, to=end)
getSymbols("VZ", src="yahoo", from=start, to=end)
getSymbols("S", src="yahoo", from=start, to=end)
getSymbols("T", src="yahoo", from=start, to=end)


vz.df <- data.frame(VZ)
tm.df <- data.frame(TMUS)
att.df <- data.frame(T) 
s.df <- data.frame(S)

df <- data.frame(cbind(rownames(tm.df), tm.df[,4], vz.df[,4], att.df[,4], s.df[,4]))

colnames(df) <- c("date","tmobile","verizon","att","sprint")
stocks <- data.frame(gather(df, company, closingPrice, tmobile:sprint))
stocks$date <- as.Date(stocks$date)
stocks$closingPrice <- as.numeric(stocks$closingPrice)

plot_ly(stocks, x=stocks$date, y=stocks$closingPrice, type="scatter", 
        mode="lines", color=stocks$company) %>%
  layout(title="Title",
         xaxis=list(title="Date"),
         yaxis=list(title="Closing Price"))
  