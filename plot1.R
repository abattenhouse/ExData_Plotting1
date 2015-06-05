
# Download the data
if (!file.exists("household_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                  destfile="household_power_consumption.zip", method="curl")
}
if (!file.exists("household_power_consumption.txt")) {
    unzip("household_power_consumption.zip")
}
stopifnot(file.exists("household_power_consumption.txt"))

# Read, clean and subset the full dataset. 
all <- read.table("household_power_consumption.txt", sep=";", header=T, 
                   na.strings="?", stringsAsFactors=F)
all$Date <- as.Date(all$Date, "%d/%m/%Y")
dat <- all[all$Date >= as.Date("2007-02-01", "%Y-%m-%d") &
           all$Date <= as.Date("2007-02-02", "%Y-%m-%d"), ]

# Plot histogram of Global Active Power
png("plot1.png", width=480, height=480, units="px")
hist(dat$Global_active_power, col='red',
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")
dev.off()

