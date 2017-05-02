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

# plot1
png(filename = "plot1.png", width = 480, height = 480)
hist(as.numeric(data$Global_active_power)*2, col = "red", main = "Global Active Power", axes=FALSE, xlab = "Global Active Power (kilowatts)")
#plot(0:23, d, type='b', axes=FALSE)
axis(side=1, at= seq(0,6, by = 2))
axis(side=2, at=seq(0, 1200, by=200))
dev.off()
