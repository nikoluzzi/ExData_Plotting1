##Check for installed packages and install them if not yet.
list.of.packages <- c("data.table", "lubridate")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

library(data.table)
library(lubridate)

##calculate size of the data frame to load
##2,075,259 rows and 9 columns
size <- 2075259*9*8
print(paste(as.character(size/2^20),"Mb"))

##Uncomment if you have the same folder structure than me :)
setwd("~/R/ExData_Plotting1") 

fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL,destfile="data.zip",method="curl")
unzip("data.zip")

##faster table reader
data <- fread("household_power_consumption.txt")

##convert first column to dates
data$Date <- dmy(data$Date)

##subset data where the Date is 2007-02-01 UTC or 2007-02-02 UTC
data <- data[((data$Date == "2007-02-01 UTC") | (data$Date == "2007-02-02 UTC")),]

##plot 1
par(mfrow=c(1,1)) ##reset in case you were experimenting in the same workspace before
global.power <- as.numeric(data$Global_active_power)
hist(global.power, xlab="Global Active Power (kilowatts)",
     col="red", main="Global Active Power")
dev.copy(png,width=480,height=480,filename="plot1.png")
dev.off()