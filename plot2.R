#Load libraries
library(data.table)
library(dplyr)
#Read data

data <- read.table("household_power_consumption.txt", 
                   header=TRUE, 
                   sep= ";", 
                   na.strings = c("?",""))

# Make sure data is in proper format by converting columns, 
# combining date and time as one in a temp column and then converting time
# to the the value in the new column
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
data$timeformat <- paste(data$Date, data$Time)
data$Time <- strptime(data$timeformat, format = "%Y-%m-%d %H:%M:%S")
data <- data[, 1:9]

# Create subset of data for days in question
dataDays <- data[which(data$Date=="2007-02-01" | data$Date== "2007-02-02"),]

# Set margin
par(mar=c(1,1,1,1))
# Create png and plot histogram for plot 2
png(filename = "plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
x <- dataDays$Time
y <- dataDays$Global_active_power

with(data, 
     plot(x, y,
          pch=NA,
          xlab="",
          main="",
          ylab="Global Active Power (kilowatts)"))
    lines(x,y)
dev.off()

