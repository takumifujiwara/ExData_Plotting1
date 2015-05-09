library(dplyr)
library(lubridate)

# to run the method
# > source("plot2.R")
# > plot2()

plot2 <- function(file) {
  # read only data between 1/2 to 2/2 from file
  rawData <- read.csv("household_power_consumption.txt", sep = ";", skip=66636, nrow=2880)
  # set headers
  names(rawData) <- c("Date","Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  # add a new column for datetime
  rawData <- mutate(rawData, DateTime=dmy_hms(paste(rawData$Date,rawData$Time)))
  # plot histogram x=DateTime and y=Global_active_power
  par(mfrow=c(1,1))
  plot(rawData$DateTime,rawData$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
  # generate and save plot2.png 
  dev.copy(png, file="plot2.png", width=480, height=480)
  dev.off()
  cat("plot2.png has been saved in", getwd())
}