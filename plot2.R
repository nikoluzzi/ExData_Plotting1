##Check for installed packages and install them if not yet.
list.of.packages <- c("data.table", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(data.table)
library(lubridate)

##calculate size 
##2,075,259 rows and 9 columns
size <- 2075259*9*8
print(paste(as.character(size/2^20),"Mb"))

##setwd("~/R/exdata-course-project-1")
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="data.zip",method="curl")
unzip("data.zip")

##faster table reader
data <- fread("household_power_consumption.txt")

##convert first column to dates
data$Date <- dmy(data$Date)

##subset data where the Date is 2007-02-01 UTC or 2007-02-02 UTC
data <- data[((data$Date == "2007-02-01 UTC") | (data$Date == "2007-02-02 UTC")),]

##plot 2
par(mar=c(4, 5, 3, 2))
global.power <- as.numeric(data$Global_active_power)
plot(global.power, type="l", xaxt = "n", 
     ylab="Global Active Power kilowatts",xlab="")
axis(side=1,at=c(0,length(global.power)/2,length(global.power)), 
     labels=c("Thu","Fri","Sat"))
dev.copy(png,width=480,height=480,filename="plot2.png")
dev.off()



