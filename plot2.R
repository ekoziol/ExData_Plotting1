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

plot(data$DateTime,data$Global_active_power,  type="l", ann=FALSE)
title(ylab="Global Active Power (kilowatts)")
dev.copy(png, "plot2.png")
dev.off()