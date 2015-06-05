
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

# Plot Global Active Power usage over two day period
png("plot2.png", width=480, height=480, units="px")
plot(x=dat$datetime, y=dat$Global_active_power,
     type='l', main="Global Active Power",
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

