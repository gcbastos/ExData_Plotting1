
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
## - the extraction requires the use of the 'sqldf'package.
## - if the 'sqldf'package is not installed, just uncomment the line below.

## install.packages("sqldf")
library(sqldf)

DF1 <-read.csv.sql(fileinfo$Name, sql = 'select * from file where Date="1/2/2007" or Date="2/2/2007"', sep=";")


## Last section:
## - sets the dir to hold the plot
## - plots the required graphic
## - outputs the plot to a PNG file
## - width, height and background parameters for PNG were added to increase compatibility with the model files.

setwd("../")

png(file = "plot1.png", width = 504, height = 504, bg = "transparent")

hist(DF1$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

dev.off()

