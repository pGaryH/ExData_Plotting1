#Plot 3

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
#rm(tb)

##################
# plot 3
#need strptime for other plots
#https://stat.ethz.ch/R-manual/R-devel/library/base/html/strptime.html
png("plot3.png", width=480, height=480) #, res=120
x <- paste(tb3$Date, tb3$Time)
tb3$dt <- strptime(x, "%d/%m/%Y %H:%M:%S")

with(tb3, plot(dt, Sub_metering_1, type = 'l', col = "black", ylab = "Energy Sub Metering"))
with(tb3, points(dt, Sub_metering_2, type = 'l', col = "coral3"))
with(tb3, points(dt, Sub_metering_3, type = 'l', col = "blue3"))
legend("topright", lty=1, col = c("black", "coral3", "blue3"), legend = c("sub_metering_1", "sub_metering_2", "sub_metering_2" ))

dev.off()