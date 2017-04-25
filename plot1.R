#-----------------------------------------------------------------------------------------------------------------------
# Filename:     Plot1.R
# Author:       Geoff Skellams
#
# File Summary: Using the Individual household electric power consumption Data Set from the  UC Irvine Machine 
#               Learning Repository, this script will read in the data from the first two days in February 2007 and
#               then plot the frequency of the Global Active Power variable to a PNG file.
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

#-------------------------------------------
# Plotting
#
# open the PNG file.
png("plot1.png")

# create the plot, including setting the title and X axis label
hist(powerset$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# close the graphics device
dev.off()