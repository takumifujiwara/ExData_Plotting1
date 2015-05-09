library(dplyr)
library(lubridate)

# to run the method
# > source("plot1.R")
# > plot1()

plot1 <- function(file) {
  # read only data between 1/2 to 2/2 from file
  rawData <- read.csv("household_power_consumption.txt", sep = ";", skip=66636, nrow=2880)
  # set headers
  names(rawData) <- c("Date","Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  # convert Global_active_power to numeric
  rawData$Global_active_power <- as.numeric(as.character(rawData$Global_active_power))
  # plot histogram x=Global_active_power and y=count
  par(mfrow=c(1,1))
  hist(rawData$Global_active_power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
  # generate and save plot1.png 
  dev.copy(png, file="plot1.png", width=480, height=480)
  dev.off()
  cat("plot1.png has been saved in", getwd())
}