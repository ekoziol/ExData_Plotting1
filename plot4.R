#check if file exists
if(!file.exists("household_power_consumption.txt")){
    message("Please unzip the file into the main directory")
}

# import the data
data <- read.csv2("household_power_consumption.txt", na.strings="?", stringsAsFactors=FALSE)

#convert Date to Date
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#select only for days of 2007-02-01 and 2007-02-02
data <- data[data$Date %in% as.Date(c('2007-02-01', '2007-02-02')),]

#convert date and time to datetime
data$DateTime <- strptime(paste(as.character(data$Date), data$Time, 
                                sep=" ") , format="%Y-%m-%d %H:%M:%S")

#convert necessary columns to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)

#initiate device and 2x2 grid
png(filename= "plot4.png", width=480, height=480)
par(mfrow = c(2,2))

#plot top left
plot(data$DateTime,data$Global_active_power,  type="l", ann=FALSE)
title(ylab="Global Active Power")

#plot for top right
plot(data$DateTime,data$Voltage,  type="l", ann=FALSE)
title(ylab="Voltage", xlab="datetime")

#plot for bottom left
plot(data$DateTime,data$Sub_metering_1, type="l", ann=FALSE)
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
title(ylab="Energy sub metering")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1,1), lwd=c(2.5,2.5,2.5), col=c("black", "red","blue"),
       bty="n")
#plot for bottom right
plot(data$DateTime,data$Global_reactive_power,  type="l", ann=FALSE)
title(ylab="Global_reative_power", xlab="datetime")


dev.off()