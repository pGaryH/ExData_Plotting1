#Plot 2

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
png("plot2.png", width=480, height=480) #, res=120
x <- paste(tb3$Date, tb3$Time)
tb3$dt <- strptime(x, "%d/%m/%Y %H:%M:%S")
with(tb3, plot(dt, Global_active_power, xlab = "day of week",ylab = "Global Active Power (kilowatts)", type = 'l'))
dev.off()

rm(tb3)