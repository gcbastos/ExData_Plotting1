
## First section of the code:
##  - creates a dir named 'data'to hold the data to be used
##  - downloads the file from the internet in .zip format
##  - unzips the file and assigns the file's information to a data frame

if (!file.exists("data")){
      dir.create("data")
}

setwd("./data")

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp, method= "curl")
fileinfo <-unzip(temp,list=TRUE)
unzip(temp)
unlink(temp)

## Second section:
## - extracts the data segment of interest from the original dataset
## - adds the 'datetime' column to the dataset by combining Date and Time original info. 
## - the extraction requires the use of the 'sqldf'package.
## - if the 'sqldf'package is not installed, just uncomment the line below.

## install.packages("sqldf")
library(sqldf)

DF1 <-read.csv.sql(fileinfo$Name, sql = 'select * from file where Date="1/2/2007" or Date="2/2/2007"', sep=";")
DF1$Date<-as.Date(DF1$Date, format="%d/%m/%Y")
tempdatetime<-paste(DF1$Date,DF1$Time)
datetime <- strptime(tempdatetime, "%Y-%m-%d %H:%M:%S")
DF1<-cbind(DF1,datetime)

## Last section:
## - sets the dir to hold the plot
## - plots the required graphic
## - outputs the plot to a PNG file
## - width, height and background parameters for PNG were added to increase compatibility with the model files.

setwd("../")

png(file = "plot3.png", width = 504, height = 504, bg = "transparent")

with(DF1, {
      plot(datetime,Sub_metering_1, type="l", ylab="Energy sub metering", xlab="" , col="black") 
      lines(datetime,Sub_metering_2, type="l",col="red")
      lines(datetime,Sub_metering_3, type="l",col="blue")
      legend("topright",lty=1, col=c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}
)

dev.off()

