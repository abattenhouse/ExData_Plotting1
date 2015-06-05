
# Download the data
if (!file.exists("household_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile="household_power_consumption.zip", method="curl")
}
if (!file.exists("household_power_consumption.txt")) {
    unzip("household_power_consumption.zip")
}
stopifnot(file.exists("household_power_consumption.txt"))

# Read the full dataset
all <- read.table("household_power_consumption.txt", sep=";", header=T, 
                   na.strings="?", stringsAsFactors=F)
# Combine date and time into one datetime field; also convert separately
all$datetime <- strptime(paste(all$Date, all$Time), "%d/%m/%Y %H:%M:%S")
all$Date <- as.Date( all$Date, "%d/%m/%Y")
all$Time <- strptime(all$Time, "%H:%M:%S")
# Create data subset
dat <- all[all$Date >= as.Date("2007-02-01", "%Y-%m-%d") &
           all$Date <= as.Date("2007-02-02", "%Y-%m-%d"), ]

# Plot Energy sub meterings over 2 day period
png("plot3.png", width=480, height=480, units="px")
plot(x=dat$datetime, y=dat$Sub_metering_1, type='l',
     xlab="", ylab="Energy sub metering")
lines(x=dat$datetime, y=dat$Sub_metering_2, type='l', col='red')
lines(x=dat$datetime, y=dat$Sub_metering_3, type='l', col='blue')
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

