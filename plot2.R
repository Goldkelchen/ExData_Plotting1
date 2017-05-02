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

# plot2
data <- mutate(data, Date2 = ymd(data$Date))
data <- mutate(data, wday = wday(data$Date2))
data$wday[data$wday == 5] <- 'Thu'
data$wday[data$wday == 6] <- 'Fri'
data <- mutate(data, Datetime = as.POSIXct(paste(data$Date,data$Time), format = "%Y-%m-%d %H:%M:%S"))

png(filename = "plot2.png", width = 480, height = 480)
plot(data$Datetime, as.numeric(data$Global_active_power)*2, yaxt = 'n', type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
axis(side=2, at=seq(0, 6, by=2))
dev.off()