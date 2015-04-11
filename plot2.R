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


png(file = "plot2.png")     #opens a PNG graphics device called "plot2"

plot(subtable$Time, subtable$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(subtable$Time, subtable$Global_active_power)
dev.off()
print("plot2.png created")
