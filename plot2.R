#set wd as needed
setwd("/Users/TNoznis/Dropbox/exploratorydataanalysis/week1/")
#install and prepare lubridate package for handling dates as needed
#install.packages("lubridate")
#library(lubridate)
file <- "./data/household_power_consumption.txt"

#read all date and set column classes for base plotters interpretation is correct
data <- read.table(file, header=TRUE, sep=";",
colClasses=c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'),
na.strings="?")

#fix dates and subset and create new date+time column for x-axis
data$Date <- as.Date(parse_date_time(data$Date,"dmy"))
data <- data[data$Date == as.Date("2007-02-01") | data$Date == as.Date("2007-02-02"),]
data$dateTime <- as.POSIXlt(paste(data$Date," ",data$Time))

#call the plot, leave the points out, and fill in with only lines
with(data,plot(dateTime, Global_active_power, type="n",xlab = "", ylab="Global Active Power (kilowatts)"))
with(data,lines(dateTime,Global_active_power))

#copy png to folder
dev.copy(png,"ExData_Plotting/plot2.png")
dev.off()

