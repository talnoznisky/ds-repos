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

#make plot
with(data, plot(dateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(data, lines(dateTime,Sub_metering_1, col="black"))
with(data, lines(dateTime,Sub_metering_2, col="red"))
with(data, lines(dateTime,Sub_metering_3, col="blue"))
legend("topright",pch=NA,col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=1)

#copy graph
dev.copy(png, "ExData_Plotting/plot3.png")
dev.off()