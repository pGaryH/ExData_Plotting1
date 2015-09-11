#Plot 4

#loaed needed libraries
library(dplyr)

#get file from url and unzip
# R reference manual & #  http://www.inside-r.org/r-doc/utils/unzip
fileUrl <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "household_power_consumption.zip"
file <- file.create(zipfile)
download.file(fileUrl, zipfile)  
unzip(zipfile, overwrite = TRUE, junkpaths = TRUE)
unlink(zipfile) # removes zipfile

# read file
fn <- "household_power_consumption.txt"
tb <- read.table(fn, header = TRUE,sep = ";", na.strings = '?')

# filters by date 
tb3 <- filter(tb, Date == "1/2/2007" | Date == "2/2/2007")
#remove original table
rm(tb)

##################
#http://www.cookbook-r.com/Graphs/Output_to_a_file/
png("plot4.png", width=480, height=480) #, res=120
x <- paste(tb3$Date, tb3$Time)
tb3$dt <- strptime(x, "%d/%m/%Y %H:%M:%S")

par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(tb3, {
  # here four plots are filled in with their respective titles
  plot(dt, Global_active_power, xlab = "day of week",ylab = "Global Active Power (kw)", type = 'l')
  plot(dt, Voltage, xlab = "day of week",ylab = "Voltage", type = 'l')
  plot(dt, Sub_metering_1, type = 'l', col = "black", ylab = "Energy Sub Metering")
  points(dt, Sub_metering_2, type = 'l', col = "coral3")
  points(dt, Sub_metering_3, type = 'l', col = "blue3")
  legend("topright", lty=1, col = c("black", "coral3", "blue3"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_2" ))
  plot(dt, Global_reactive_power, xlab = "day of week",ylab = "Global Reactive Power (kw)", type = 'l')
  # this adds a line of text in the outer margin*
  mtext("Plot 4", outer = TRUE)}
)
dev.off()

rm(tb3)