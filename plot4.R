#-----------------------------------------------------------------------------------------------------------------------
# Filename:     Plot4.R
# Author:       Geoff Skellams
#
# File Summary: Using the Individual household electric power consumption Data Set from the  UC Irvine Machine 
#               Learning Repository, this script will read in the data from the first two days in February 2007 and
#               then creates four separate plots on the same graphics device:
#                   1) Global Active Power over time (same as plot2)
#                   2) Voltage over time
#                   3) Sub meter readings over time (same as plot 3)
#                   4) Global reactive power over time
#
#               This script assumes that the data file is already present in the current working directory.
#-----------------------------------------------------------------------------------------------------------------------

#-------------------------------------------
# Data Loading
#
# read in only the data we need from the overall data file.
powerset <- read.table("household_power_consumption.txt", sep = ";", nrows = 2880, skip = 66637)

# because skipping lines in the file doesn't give us the variable names, read the top two lines of the file, including
# the header
powersetHeaders <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", nrows = 1)

# set the variable names of our main dataset to be the same as the variable names in our short set
colnames(powerset) <- colnames(powersetHeaders)

# get rid of the short dataset, as we don't need it any more.
rm(powersetHeaders)

# add a datetime column to the dataset, by combining the date and time fields, and parsing it to an R object
powerset$datetime <- strptime(paste(powerset$Date, powerset$Time), format = "%d/%m/%Y %H:%M:%S")


#-------------------------------------------
# Plotting
#
# open the PNG file.
png("plot4.png")

# set the graphics device up to show four plots in a 2x2 grid
par(mfrow = c(2,2))

#-------
# PLOT 1
# create the base plot, including turning off the x-axis label and setting the y-axis label, but do NOT insert the data
plot(powerset$datetime, type="n", powerset$Global_active_power, xlab = "", ylab = "Global Active Power")

# insert the data as a continuous line plot.
lines(powerset$datetime, powerset$Global_active_power)

#-------
# PLOT 2
# create the base plot, including turning off the x-axis label and setting the y-axis label, but do NOT insert the data
plot(powerset$datetime, type="n", powerset$Voltage, xlab = "datetime", ylab = "Voltage")

# insert the data as a continuous line plot.
lines(powerset$datetime, powerset$Voltage)

#-------
# PLOT 3
# create the base plot, including turning off the x-axis label and setting the y-axis label, but do NOT insert the data
plot(powerset$datetime, type="n", powerset$Sub_metering_1, xlab = "", ylab = "Energy sub metering")

# insert the data as a continuous line plot.
lines(powerset$datetime, powerset$Sub_metering_1)
lines(powerset$datetime, powerset$Sub_metering_2, col = "red")
lines(powerset$datetime, powerset$Sub_metering_3, col = "blue")

# build the legend
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1, 1, 1),
       lwd = c(1, 1, 1),
       col = c("black", "red", "blue"),
       bty = "n")

#-------
# PLOT 4
# create the base plot, including turning off the x-axis label and setting the y-axis label, but do NOT insert the data
plot(powerset$datetime, type="n", powerset$Global_reactive_power, xlab = "datetime", ylab = "Global_reactive_power")

# insert the data as a continuous line plot.
lines(powerset$datetime, powerset$Global_reactive_power)


# close the file
dev.off()