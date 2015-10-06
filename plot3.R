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

##plot 3
par(cex=0.7, mar=c(4, 7, 3, 3))
sub_metering_1 <- as.numeric(data$Sub_metering_1)
sub_metering_2 <- as.numeric(data$Sub_metering_2)
sub_metering_3 <- as.numeric(data$Sub_metering_3)
plot(sub_metering_1, type="l", xaxt = "n", ylab="Energy sub metering",xlab="")
points(sub_metering_2, type="l", col="red")
points(sub_metering_3, type="l", col="blue")
axis(side=1,at=c(0,length(global.power)/2,length(global.power)), 
     labels=c("Thu","Fri","Sat"))
legend("topright", col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       lty=1,text.width=800)
dev.copy(png,width=480,height=480,filename="plot3.png")
dev.off()