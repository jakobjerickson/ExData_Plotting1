require(dplyr)

#the if statement evaluates if "subtable" exists, and if not, it reads the data in from the .txt file, 
#converting the Data/Time columns to POSIXlt, and subsets on the days "2007/02/02" and "2007/02/01"


if(!any(ls() == "subtable")){
        print("reading data...")
        path <- "household_power_consumption.txt"
        colClasses <- c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric")
        mytable <- read.table(path, header = T, sep = ";", na.strings = "?", colClasses = colClasses) 
        mytable$Time <- do.call("paste", mytable[,1:2])
        mytable$Time <- strptime(mytable$Time, "%d/%m/%Y %H:%M:%S")
        subtable <- mytable[which((mytable$Time$yday == 31 | mytable$Time$yday == 32) & mytable$Time$year == 107),2:9]                
} 

png(file = "plot1.png")     #opens a PNG graphics device called "plot1"

#hist function creates the desired plot
hist(subtable$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", main = "Global Active Power")
dev.off()   #closes the device
print("plot1.png created")
