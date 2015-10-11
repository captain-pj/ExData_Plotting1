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
# Create png and plot four plots on one window
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white")
x <- dataDays$Time
y <- dataDays$Global_active_power
y1 <- dataDays$Sub_metering_1
y2 <- dataDays$Sub_metering_2
y3 <- dataDays$Sub_metering_3
y4 <- dataDays$Voltage
y5 <- dataDays$Global_reactive_power

# Set window for displaying four graphs
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))
# Plot 1
with(data, 
     plot(x, y,
          pch=NA,
          xlab="",
          main="",
          ylab="Global Active Power (kilowatts)"))
lines(x,y)

# Plot 2
with(data, 
     plot(x, y4,
          pch=NA,
          xlab="datetime",
          main="",
          ylab="Voltage"))
lines(x,y4)

# Plot 3
with(data, 
     plot(x, y1,
          ylim=c(0,38),
          pch=NA,
          xlab="",
          main="",
          ylab="Energy Sub Metering"))
lines(x,y1)
lines(x,y2, col=2)
lines(x,y3, col=4)
legend("topright",
       c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
       lty=c(1,1),
       lwd=c(2.5,2.5),
       col=c(1,2,4))
# Plot 4
with(data, 
     plot(x, y5,
          pch=NA,
          xlab="datetime",
          main="",
          ylab="Global_reactive_power"))
lines(x,y5)
dev.off()

