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


 myplot4 <- function() {
    
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

#1.Convert the submetering data if it is in factors. Check str(data) to confirm
#as.numeric( as.character( ff ) )

myData <- data

d1 <- as.Date(myData$Date, format="%d/%m/%Y")
t1 <- myData$Time

newTime <- strptime(paste(d1,t1),format="%Y-%m-%d %H:%M:%S")

png(filename="./plot4.png")

par(mfrow=c(2,2))

plot(x=newTime,y=myData$Global_active_power,main="",xlab="",ylab="Global Active Power(kilowatts)",type="l")
plot(x=newTime,y=myData$Voltage,main="",xlab="datetime",ylab="Voltage",type="l")

plot (x=newTime, y= myData$Sub_metering_1,type ="l",
      xlab ="",
      ylab = "Energy sub metering")

## add additional lines
lines (x= newTime, y= myData$Sub_metering_2, col ="red")
lines (x= newTime, y= myData$Sub_metering_3, col ="blue")
## Add Legend 
legend("topright" , # places a legend at the appropriate place 
       c("Sub_metering_1 ","Sub_metering_2","Sub_metering_3"), # puts text in the legend 
       
       lty=c(1,1,1), # gives the legend appropriate symbols (lines)
       bty="n",
       lwd=c(2.5,2.5,2.5),col=c("black", "red","blue")) # gives the legend lines the correct color and width

plot(x=newTime,y=myData$Global_reactive_power,main="",xlab="datetime",ylab="Global_reactive_power",type="l")

dev.off()
 
}