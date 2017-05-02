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

png(filename = "plot2.png", width = 480, height = 480)
data <- mutate(data, Date2 = ymd(data$Date))
data <- mutate(data, wday = wday(data$Date2))
data$wday[data$wday == 5] <- 'Thu'
data$wday[data$wday == 6] <- 'Fri'
data <- mutate(data, Datetime = as.POSIXct(paste(data$Date,data$Time), format = "%Y-%m-%d %H:%M:%S"))

# plot4
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2), mar = c(4,4,1,1))
#sub1
plot(data$Datetime, as.numeric(data$Global_active_power)*2, yaxt = 'n', type = "l", xlab = "", ylab = "Global Active Power")
axis(side=2, at=seq(0, 6, by=2))
#sub2
plot(data$Datetime, data$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
#sub3
plot(data$Datetime, data$Sub_metering_1, type = "S", xlab = "", yaxt = 'n', ylab = "Energy sub metering")
lines(data$Datetime, as.numeric(data$Sub_metering_2), type = "S", col = "chocolate1")
lines(data$Datetime, data$Sub_metering_3, type = "S", col = "blue")
axis(side=2, at=seq(0, 30, by=10))
#sub4
plot(data$Datetime, as.numeric(data$Global_reactive_power)/1000*2, yaxt = 'n', type = "l", xlab = "datetime", ylab = "Global_reactive_power")
axis(side=2, at=seq(0, 0.6, by=0.1))
#save
dev.off()

