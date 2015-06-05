
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

# Create panel with 4 sub-plots
png("plot4.png", width=480, height=480, units="px")

# Specify that there will be 2 rows of plots with 2 columns each
par(mfrow = c(2,2))
# Specify the margins for each individual plot, in number of "lines" 
# (i.e., line height based on font size)
par(mar = c(4, 4.1, 2, 1)) # bottom, left, top, right
# Specify the outer margin for the plot set as a whole (here none)
par(oma = c(0, 0, 0, 0))

# row 1 col 1: Global Active Power usage over two day period
plot(x=dat$datetime, y=dat$Global_active_power, type='l', 
     xlab="", ylab="Global Active Power (kilowatts)")

# row 1 col 2: Voltage over two day period
with(dat, plot(x=datetime, y=Voltage, type='l'))

# row 2 col 1: Energy sub meterings over 2 day period
plot(x=dat$datetime, y=dat$Sub_metering_1, type='l',
     xlab="", ylab="Energy sub metering")
lines(x=dat$datetime, y=dat$Sub_metering_2, type='l', col='red')
lines(x=dat$datetime, y=dat$Sub_metering_3, type='l', col='blue')
legend("topright", lwd=1, col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# row 2 col 2: Global reactive power over two day period
with(dat, plot(x=datetime, y=Global_reactive_power, type='l'))

dev.off()

