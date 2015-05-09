library(dplyr)
library(lubridate)

# to run the method
# > source("plot3.R")
# > plot3()

plot3 <- function(file) {
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
  # plot histogram x=DateTime and y=Sub_metering_1
  par(mfrow=c(1,1))
  plot(rawData$DateTime,rawData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  # add x=DateTime and y=Sub_metering_2
  lines(rawData$DateTime,rawData$Sub_metering_2,col="red")
  # add x=DateTime and y=Sub_metering_3
  lines(rawData$DateTime,rawData$Sub_metering_3,col="blue")
  # add legend at top right
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))
  # generate and save plot3.png 
  dev.copy(png, file="plot3.png", width=480, height=480)
  dev.off()
  cat("plot3.png has been saved in", getwd())
}