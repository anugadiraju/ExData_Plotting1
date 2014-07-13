## Dataset: Electric power consumption [20Mb]

## Description: Measurements of electric power consumption in one household with a one-minute
## sampling rate over a period of almost 4 years. Different electrical quantities and some sub-metering values are available.
## The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
    
## Date: Date in format dd/mm/yyyy
## Time: time in format hh:mm:ss
## Global_active_power: household global minute-averaged active power (in kilowatt)
## Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
## Voltage: minute-averaged voltage (in volt)
## Global_intensity: household global minute-averaged current intensity (in ampere)
## Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
## Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
## Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.


 myplot2 <- function() {
    
## 1. Read in data
## We will only be using data from the dates 2007-02-01 and 2007-02-02. 
## One alternative is to read the data from just those dates rather than reading in the entire dataset and 
## subsetting to those dates.
    
## You may find it useful to convert the Date and Time variables to Date/Time classes in R using the strptime() and as.Date() functions.
    
##Note that in this dataset missing values are coded as ?.
    
##  R just executes the string in the brackets of pipe, literally like in the command prompt.
     
## Try this in the windows command prompt
     
## findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt |more

data <- read.table(pipe('findstr /B /R ^[1-2]/2/2007 household_power_consumption.txt'),header=F, sep=';',na.strings="?") 
 
colnames(data) <-names(read.table('household_power_consumption.txt', header=TRUE,sep=";",nrows=1))

#1.Convert the Date from the original dataset to date format  - d/m/yyyy  fomrat
#2.Do not use strptime on the original dataset.The problem is it directly appends today's date to the timestamps which we do not want.
#3.Paste the original timestamp with the converted date.
#4.Now apply strptime and then plot.

#data$Date <- as.Date(data$Date)
#dateTime <- strptime( paste(data$Date,data$Time), format="%Y-%m-%d %H:%M:%S")

myData <- data
d1 <- as.Date(myData$Date, format="%d/%m/%Y")
t1 <- myData$Time

x <- strptime(paste(d1,t1),format="%Y-%m-%d %H:%M:%S")
y <- myData$Global_active_power

png(filename="./plot2.png")

plot(x,y,main="Global Active Power",xlab="Time",ylab="Global Active Power(kilowatts)",type="l")

dev.off()
 
}