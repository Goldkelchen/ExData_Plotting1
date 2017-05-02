library(graphics)
library(grDevices)
library(dplyr)
library(lubridate)

setwd('H:/Programming/Coursera_Lib/ExploratoryDataAnalysis/Week1')
a <- read.table('household_power_consumption.txt', header = TRUE, sep = ';', nrows = 549672)
a[a == '?'] <- 'NA'

a$Date <- as.Date(a$Date, format = "%d/%m/%Y")
data <- with(a, a[a$Date == as.Date("2007-02-01") | a$Date == as.Date("2007-02-02") ,])
data$Global_active_power <- as.numeric(data$Global_active_power)/1000

data <- mutate(data, Date2 = ymd(data$Date))
data <- mutate(data, wday = wday(data$Date2))
data$wday[data$wday == 5] <- 'Thu'
data$wday[data$wday == 6] <- 'Fri'
data <- mutate(data, Datetime = as.POSIXct(paste(data$Date,data$Time), format = "%Y-%m-%d %H:%M:%S"))


# plot3
png(filename = "plot3.png", width = 480, height = 480)
plot(data$Datetime, data$Sub_metering_1, type = "S", xlab = "", yaxt = 'n', ylab = "Energy sub metering")
lines(data$Datetime, as.numeric(data$Sub_metering_2), type = "S", col = "chocolate1")
lines(data$Datetime, data$Sub_metering_3, type = "S", col = "blue")
axis(side=2, at=seq(0, 30, by=10))
dev.off()
