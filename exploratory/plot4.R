# Plot 1 from Course 4 - Week 1

# Assume household_power_consumption.txt file is extracted in working directory

plot4 <- function()
{
    # Load Necessary libraries
    library(dplyr)
    
    rawData <- "./household_power_consumption.txt"
    
    classes <- c("character", "character", "numeric", "numeric", "numeric",
                 "numeric","numeric", "numeric", "numeric")
    
    rTable  <- read.table(file = rawData, header = TRUE, sep = ";",
                          colClasses = classes, na.strings = "?")
    
    rTable$dateTime <- paste(rTable$Date," ",rTable$Time)
    
    rTable$dateTime <- strptime(rTable$dateTime,
                                format = "%d/%m/%Y %H:%M:%S")
    
    rTable$Date <- as.Date(rTable$Date, format = "%d/%m/%Y")
    
    #rTable$Time <- strptime(rTable$Time, "%H:%M:%S")
    
    newTable <- subset(rTable, Date >= "2007-02-01" & Date <= "2007-02-02")
    
    newTable$Time <- NULL
    
    par(mfrow = c(2,2))
    
    ## Upper Left Plot
    # Create blank plot since we don't want points, just lines
    with(newTable, plot(dateTime, Global_active_power,
                        type = "n",
                        ylab = "Global Active Power (kilowatts)",
                        xlab = ""))
    
    # Add lines
    with(newTable, lines(dateTime, Global_active_power))
    
    ## Upper Right Plot
    # Create blank plot since we don't want points, just lines
    with(newTable, plot(dateTime, Voltage,
                        type = "n",
                        ylab = "Voltage",
                        xlab = "datetime"))
    
    # Add lines
    with(newTable, lines(dateTime, Voltage))
    
    
    ## Lower Left Plot
    # Create blank plot since we don't want points, just lines
    with(newTable, plot(dateTime, Sub_metering_1,
                        type = "n",
                        ylab = "Energy sub metering",
                        xlab = ""))
    
    # Add lines
    with(newTable, lines(dateTime, Sub_metering_1, col="black"))
    
    with(newTable, lines(dateTime, Sub_metering_2, col="red"))
    
    with(newTable, lines(dateTime, Sub_metering_3, col="blue"))
    
    legend("top",
           lty = 1,
           col = c("black", "red", "blue"),
           legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"),
           bty = "n")
    
    ## Lower Right Plot
    # Create blank plot since we don't want points, just lines
    with(newTable, plot(dateTime, Global_reactive_power,
                        type = "n",
                        ylab = "Global_reactive_power",
                        xlab = "datetime"))
    
    # Add lines
    with(newTable, lines(dateTime, Global_reactive_power))
    
    
    dev.copy(png, file = "plot4.png", width = 480, height = 480)
    
    dev.off()
    
}