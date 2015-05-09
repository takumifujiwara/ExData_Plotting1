library(dplyr)
library(lubridate)

# to run the method
# > source("plot4.R")
# > plot4()

plot4 <- function(file) {
  # read only data between 1/2 to 2/2 from file
  rawData <- read.csv("household_power_consumption.txt", sep = ";", skip=66636, nrow=2880)
  # set headers
  names(rawData) <- c("Date","Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  # add a new column for datetime
  rawData <- mutate(rawData, DateTime=dmy_hms(paste(rawData$Date,rawData$Time)))
  # convert columns to numeric
  rawData$Sub_metering_1 <- as.numeric(as.character(rawData$Sub_metering_1))
  rawData$Sub_metering_2 <- as.numeric(as.character(rawData$Sub_metering_2))
  rawData$Sub_metering_3 <- as.numeric(as.character(rawData$Sub_metering_3))
  rawData$Global_active_power <- as.numeric(as.character(rawData$Global_active_power))
  rawData$Global_reactive_power <- as.numeric(as.character(rawData$Global_reactive_power))
  rawData$Voltage <- as.numeric(as.character(rawData$Voltage))
  
  # Prepare 2x2 space for 4 graphs
  par(mfrow=c(2,2))
  
  # plot first graph with histogram x=DateTime and y=count
  plot(rawData$DateTime,rawData$Global_active_power, type="l", xlab="", ylab="Global Active Power")
  # plot first graph with histogram x=DateTime and y=Voltage
  plot(rawData$DateTime,rawData$Voltage, type="l", xlab="datetime", ylab="Voltage")
  # plot third graph with histogram x=DateTime and y=Sub_metering_1, Sub_metering_2, Sub_metering_3 and add legend
  plot(rawData$DateTime,rawData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(rawData$DateTime,rawData$Sub_metering_2,col="red")
  lines(rawData$DateTime,rawData$Sub_metering_3,col="blue")
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), bty="n", cex=.5) #bty removes the box, cex shrinks the text, spacing added after labels so it renders correctly
  # plot fourth graph with histogram x=DateTime and y=Global_reactive_power
  plot(rawData$DateTime,rawData$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
  # generate and save plot4.png 
  dev.copy(png, file="plot4.png", width=480, height=480)
  dev.off()
  cat("plot4.png has been saved in", getwd())
}