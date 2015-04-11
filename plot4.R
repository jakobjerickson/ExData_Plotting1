

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


png(file = "plot4.png")     #opens a PNG graphics device called "plot4"
par("mfrow" = c(2,2))  #sets up plot to have 2x2 format


#upper left
plot(subtable$Time, subtable$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(subtable$Time, subtable$Global_active_power)


#upper right
plot(subtable$Time, subtable$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(subtable$Time, subtable$Voltage)


#lower left
plot(subtable$Time, subtable$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(subtable$Time, subtable$Sub_metering_1, col = "black")
lines(subtable$Time, subtable$Sub_metering_2, col = "red")
lines(subtable$Time, subtable$Sub_metering_3, col = "blue")
legend("topright", lty = "solid", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#lower right
plot(subtable$Time, subtable$Global_reactive_power, type = "n", xlab = "", ylab = "Global_reactive_power")
lines(subtable$Time, subtable$Global_reactive_power)

dev.off()

print("plot4.png created")
